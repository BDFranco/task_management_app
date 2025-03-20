class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [ :edit, :update, :mark_as_completed ]
  before_action :authorize_admin, only: [ :new, :create ]

  def index
    @tasks = Task.all.order(:due_date)
  end

  def dashboard
    @tasks = Task.where(assigned_to: current_user.id).order(:due_date) # Only show tasks assigned to the current user
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: "Task created successfully."
    else
      render :new
    end
  end

  def edit
    unless current_user.admin? || @task.assigned_to == current_user.id
      redirect_to tasks_path, alert: "You are not authorized to edit this task."
    end
  end

  def update
    if current_user.admin? || @task.assigned_to == current_user.id
      if @task.update(task_params)
        redirect_to tasks_path, notice: "Task updated successfully."
      else
        render :edit
      end
    else
      redirect_to tasks_path, alert: "You are not allowed to update this task."
    end
  end

  # Custom action to mark a task as completed
  def mark_as_completed
    if @task.assigned_to == current_user.id
      @task.update(status: "completed", completed_at: Time.current)
      redirect_to dashboard_path, notice: "Task marked as completed."
    else
      redirect_to dashboard_path, alert: "You can only complete your assigned tasks."
    end
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :status, :due_date, :assigned_to)
  end
end
