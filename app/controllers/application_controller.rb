class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def after_sign_in_path_for(resource)
    if current_admin
      admin_root_path
    else
      dashboard_path
    end
  end
end
