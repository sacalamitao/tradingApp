class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    before_action :configure_permitted_parameters, if: :devise_controller?

    # def after_sign_in_path_for_admin(_form)
    #      current_user.admin == true ? rails_admin_path : root_path
    # end

    protected

         def configure_permitted_parameters
              devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:firstname, :lastname, :username, :email, :password, :password_confirmation, :role)}

              devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:firstname, :lastname, :username, :email, :password, :current_password)}
         end
end