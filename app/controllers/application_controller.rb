class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def authorize_admin
    redirect_to root_path, alert: "Only Admins can perform this action." unless current_user.admin?
  end
end
