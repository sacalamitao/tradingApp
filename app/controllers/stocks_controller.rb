class StocksController < ApplicationController
  before_action :set_stock, only: %i[ show edit update destroy ]
  before_action :correct_user, only: %i[ edit update destroy]
  before_action :authenticate_user!

  # GET /stocks or /stocks.json
  def index
    @stocks = Stock.all
    @api = StockQuote::Stock.new(api_key: 'pk_50b7099e20a147dbaaea15e037a2e9f1')

    # FOR SEARCH QUERY
    # once the form filled out, send "ticker" params to the StockQuote
    # and return the result to @stock instance variable

    # error handling
     # to check if params has empty value
    if params[:ticker] == ""
      @empty_error_msg = "Please Enter A Stock Symbol!"
    elsif params[:ticker]
      @stock = StockQuote::Stock.quote(params[:ticker])
        # to check if params has junk or gibberish value
      if !@stock
          @junk_error_msg = "Stock Symbol Doesn't Exist. Please Try Again!"
      end
    end
  end

  # GET /stocks/1 or /stocks/1.json
  def show
  end

  # GET /stocks/new
  def new
    @stock = Stock.new
  end

  # GET /stocks/1/edit
  def edit
  end

  # POST /stocks or /stocks.json
  def create
    @stock = Stock.new(stock_params)

    respond_to do |format|
      if @stock.save
        format.html { redirect_to @stock, notice: "Stock was successfully created." }
        format.json { render :show, status: :created, location: @stock }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stocks/1 or /stocks/1.json
  def update
    respond_to do |format|
      if @stock.update(stock_params)
        format.html { redirect_to @stock, notice: "Stock was successfully updated." }
        format.json { render :show, status: :ok, location: @stock }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stocks/1 or /stocks/1.json
  def destroy
    @stock.destroy
    respond_to do |format|
      format.html { redirect_to stocks_url, notice: "Stock was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def logged_user
    @ticker = current_user.stocks.find_by(id: params[:id])
    redirect_to stocks_path, notice: "You are not authorized to edit this stock!" if @ticker.nil?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stock
      @stock = Stock.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def stock_params
      params.require(:stock).permit(:ticker, :user_id)
    end
end
