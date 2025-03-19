class ProjectsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin, only: [ :new, :create, :edit, :update, :destroy ]

    def index
      @projects = Project.all
    end

    def show
      @project = Project.find(params[:id])
    end

    def new
      @project = Project.new
    end

    def create
      @project = Project.new(project_params)
      @project.created_by = current_user.id
      if @project.save
        redirect_to @project, notice: "Project created successfully."
      else
        render :new
      end
    end

    def edit
      @project = Project.find(params[:id])
    end

    def update
      @project = Project.find(params[:id])
      if @project.update(project_params)
        redirect_to @project, notice: "Project updated successfully."
      else
        render :edit
      end
    end

    def destroy
      @project = Project.find(params[:id])
      @project.destroy
      redirect_to projects_path, notice: "Project deleted successfully."
    end

    private

    def project_params
      params.require(:project).permit(:name, :description)
    end

    def authorize_admin
      redirect_to root_path, alert: "Access denied!" unless current_user.admin?
    end
end
