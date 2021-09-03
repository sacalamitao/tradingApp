class HomeController < ApplicationController
  def index
    if current_user&.admin?
      if params[:approved] == "false"
        @users = User.where(approved: false)
      else
        @users = User.all
      end
    end
    @needs_approval = User.where(approved: false)
  end
end
