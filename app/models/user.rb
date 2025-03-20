class User < ApplicationRecord
  has_many :tasks, foreign_key: :assigned_to
  has_many :projects, foreign_key: :creator_by

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  def admin?
    role == "admin"  # Works only if role is a string column
  end
end
