class Task < ApplicationRecord
    # Statuses
    STATUSES = [ "pending", "in_progress", "completed" ]
    # Relationships
    belongs_to :project
    belongs_to :assignee, class_name: "User", foreign_key: :assigned_to

    # Validations
    validates :title, presence: true
    validates :description, presence: true
    validates :status, presence: true, inclusion: { in: STATUSES }
    validates :due_date, presence: true
    validates :assigned_to, presence: true

    # Define
    def pending?
        status == "pending"
    end

    def in_progress?
        status == "in_progress"
    end

    def completed?
        status == "completed"
    end
end
