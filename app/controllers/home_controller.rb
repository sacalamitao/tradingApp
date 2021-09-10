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
    @stocks = Stock.all
  end

  def show

  end

  def destroy
    @stock.destroy
    respond_to do |format|
      format.html { redirect_to stocks_url, notice: "Stock was successfully destroyed." }
      format.json { head :no_content }
    end
  end


end
