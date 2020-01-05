class Lesson < ApplicationRecord
  belongs_to :group
  belongs_to :teacher, class_name: "User", foreign_key: 'teacher_id'

  has_many :attendances, dependent: :delete_all
  has_many :absences, dependent: :delete_all
  has_many :students, through: :attendances, class_name: "User"

  def attach_info
    as_json.merge(
      teacher: teacher,
      group: group
    )
  end

  def self.create_weekly (lesson, until_date)
    period_start = lesson.start_time
    period_end   = DateTime.parse(until_date) + 1.day

    time_start = Time.parse(lesson.start_time.to_s(:time))
    time_end   = Time.parse(lesson.end_time.to_s(:time))

    lessons = []
    (period_start.to_i..period_end.to_i).step(7.day) do |day|
      next if day == period_start.to_i
      day = Time.zone.at(day).to_date

      lessons << { 
        group_id: lesson.group_id,
        teacher_id: lesson.teacher_id,
        start_time: Utils.datetime_from_date_and_time(day, time_start),
        end_time: Utils.datetime_from_date_and_time(day, time_end)
      }
    end

    Lesson.create(lessons)
  end

  def self.update_with_type(time_slot:, type:, params:)
    s, e = params[:start], params[:end]
    day  = time_slot.start.to_date
    s    = Utils.datetime_from_date_and_time(day, Time.zone.parse(s))
    e    = Utils.datetime_from_date_and_time(day, Time.zone.parse(e))
    case type.to_sym
    when :one
      time_slot.update(params)
    when :all
      sql = sanitize_sql_for_assignment([<<~SQL.split("\n").join(" "), start: s, end: e, title: params[:title]])
          start = date_trunc('day', start) +
          date_part('hour', TIMESTAMP :start) * interval '1 hour' +
          date_part('minute', TIMESTAMP :start) * interval '1 minute' +
          date_part('second', TIMESTAMP :start) * interval '1 second',
          "end" = date_trunc('day', "end") +
          date_part('hour', TIMESTAMP :end) * interval '1 hour' +
          date_part('minute', TIMESTAMP :end) * interval '1 minute' +
          date_part('second', TIMESTAMP :end) * interval '1 second',
          title = :title
        SQL
      
      TimeSlot.with_start_and_end_daily(time_slot.start, time_slot.end, 1)
        .with_start_date_greater_than(time_slot.start)
        .update_all(sql)
    end
  end

  def self.destroy_with_type(time_slot:, type:)
    case type.to_sym
    when :one
      time_slot.destroy
    when :all
      year = time_slot.school_year
      TimeSlot.with_start_and_end_daily(time_slot.start, time_slot.end, 1)
        .with_start_date_greater_than(time_slot.start)
        .destroy_all
    end
  end
end