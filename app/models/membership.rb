class Membership < ApplicationRecord
  belongs_to :member, class_name: "User"
  belongs_to :project, class_name: "Node"
end
