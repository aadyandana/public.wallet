class StockPriceController < ApplicationController
  skip_before_action :authenticate

  # Simplify Services with Alias
  PriceService = Externals::Aadyandana::LatestStockPrice::Client::PriceService
  PricesService = Externals::Aadyandana::LatestStockPrice::Client::PricesService
  PriceAllService = Externals::Aadyandana::LatestStockPrice::Client::PriceAllService

  def price
    stock = PriceService.new(params).call

      render json: { status: 200, data: stock }, status: :ok
  rescue => e
    render json: { status: 500, error: e.message }, status: :internal_server_error
  end

  def prices
    stocks = PricesService.new(params).call

      render json: { status: 200, data: stocks }, status: :ok
  rescue => e
    render json: { status: 500, error: e.message }, status: :internal_server_error
  end

  def price_all
    stocks = PriceAllService.new.call

      render json: { status: 200, data: stocks }, status: :ok
  rescue => e
    render json: { status: 500, error: e.message }, status: :internal_server_error
  end
end
