class HomeController < ApplicationController
  def index
    @projects = Project.includes(:tasks).all
  end
end
