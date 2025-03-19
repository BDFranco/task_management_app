class TasksController < ApplicationController
    before_action :authenticate_user!
    before_action :set_task, only: [:edit, :update]
    before_action :admin_only, only: [:new, :create]
  
    def index
      @tasks = Task.all.order(:due_date)
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
  
    private
  
    def set_task
      @task = Task.find(params[:id])
    end
  
    def task_params
      params.require(:task).permit(:title, :description, :status, :due_date, :assigned_to)
    end
  
    def admin_only
      redirect_to tasks_path, alert: "Only Admins can perform this action." unless current_user.admin?
    end
  end
  