# frozen_string_literal: true

# == Schema Information
#
# Table name: tags
#
#  id          :bigint(8)        not null, primary key
#  topic_id    :bigint(8)
#  report_id   :bigint(8)
#  question_id :bigint(8)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class TagTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
