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
    validate :due_date_cannot_be_in_the_past
    validates :project_id, presence: true

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

    def due_date_cannot_be_in_the_past
        if due_date.present? && due_date < Date.today
          errors.add(:due_date, "cannot be in the past")
        end
    end
end
