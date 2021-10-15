class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    before_action :configure_permitted_parameters, if: :devise_controller?

    # def after_sign_in_path_for_admin(_form)
    #      current_user.admin == true ? rails_admin_path : root_path
    # end

#     @stocks = Stock.all
#     @api = StockQuote::Stock.new(api_key: 'pk_50b7099e20a147dbaaea15e037a2e9f1')

#     # FOR SEARCH QUERY
#     # once the form filled out, send "ticker" params to the StockQuote
#     # and return the result to @stock instance variable

#     # error handling
#      # to check if params has empty value
#     if params[:ticker] == ""
#       @empty_error_msg = "Please Enter A Stock Symbol!"
#     elsif params[:ticker]
#       @stock = StockQuote::Stock.quote(params[:ticker])
#         # to check if params has junk or gibberish value
#       if !@stock
#           @junk_error_msg = "Stock Symbol Doesn't Exist. Please Try Again!"
#       end
#     end


    protected

         def configure_permitted_parameters
              devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:firstname, :lastname, :username, :email, :password, :password_confirmation, :role)}

              devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:firstname, :lastname, :username, :email, :password, :current_password)}
         end


end
