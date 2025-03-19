class Task < ApplicationRecord
    # Validations
    validates :title, presence: true
    validates :description, presence: true
    validates :status, presence: true
    validates :due_date, presence: true
    validates :assigned_to, presence: true
  end