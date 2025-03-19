class Task < ApplicationRecord
    # Relationships
    belongs_to :project
    belongs_to :assignee, class_name: "User", foreign_key: :assigned_to

    # Validations
    validates :title, presence: true
    validates :description, presence: true
    validates :status, presence: true
    validates :due_date, presence: true
    validates :assigned_to, presence: true
end
