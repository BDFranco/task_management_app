class Project < ApplicationRecord
    has_many :tasks
    belongs_to :creator, class_name: "User", foreign_key: :created_by
end
