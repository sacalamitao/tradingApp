class StocksController < ApplicationController
  before_action :set_stock, only: %i[ show edit update destroy ]

  # GET /stocks or /stocks.json
  def index
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

  # def get_data
  #   client = IEX::Api::Client.new(
  #     publishable_token: ENV['IEX_API_PUBLISHABLE_TOKEN'],
  #     endpoint: 'https://cloud.iexapis.com/v1'
  #     # endpoint: 'https://sandbox.iexapis.com/v1'
  #   )
  #   symbol = params[:symbol]

  #   company_name = client.key_stats(symbol).company_name
  #   latest_price = client.quote(symbol).latest_price
  #   market_cap = client.key_stats(symbol).market_cap
  #   render json: [company_name, latest_price, market_cap]
  # end

  # GET /stocks/1 or /stocks/1.json
  def show
  end

  # GET /stocks/new
  def new
    @stock = Stock.new

    client = IEX::Api::Client.new(
      publishable_token: 'pk_c21fd8480135463598bd761d36f2eacf',
      secret_token: 'sk_db92a051398242dcac50b1f3d7c22f61',
      endpoint: 'https://cloud.iexapis.com/v1'
    )
    
    symbol = client.ref_data_symbols.take(20).map { |s| s.symbol }
    @company_name = symbol.map { |s| client.key_stats(s).company_name }
    @market_cap = symbol.map { |s| client.key_stats(s).market_cap }
    # @price = figures.map { |s| client.qoute(s).latest_price }
    # @cap = figures.map { |s| client.key_stats(s).market_cap }

    # @all_names = @name.map { |n| [n, n]}
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stock
      @stock = Stock.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def stock_params
      params.require(:stock).permit(:company, :ticker, :current_price, :market_cap)
    end
end
