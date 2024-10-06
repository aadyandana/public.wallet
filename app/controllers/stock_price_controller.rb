class StockPriceController < ApplicationController
  skip_before_action :authenticate

  # Simplify Services with Alias
  PriceService = Externals::Aadyandana::LatestStockPrice::Client::PriceService
  PricesService = Externals::Aadyandana::LatestStockPrice::Client::PricesService
  PriceAllService = Externals::Aadyandana::LatestStockPrice::Client::PriceAllService

  def price
    stock = PriceService.new(params).call

    standard_response(stock)
  rescue => e
    error_response(e.message)
  end

  def prices
    stocks = PricesService.new(params).call

    standard_response(stocks)
  rescue => e
    error_response(e.message)
  end

  def price_all
    stocks = PriceAllService.new.call

    standard_response(stocks)
  rescue => e
    error_response(e.message)
  end
end
