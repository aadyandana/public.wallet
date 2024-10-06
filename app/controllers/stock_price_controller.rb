class StockPriceController < ApplicationController
  skip_before_action :authenticate

  # Simplify Services with Alias
  PriceService = Externals::Aadyandana::LatestStockPrice::Client::PriceService
  PricesService = Externals::Aadyandana::LatestStockPrice::Client::PricesService
  PriceAllService = Externals::Aadyandana::LatestStockPrice::Client::PriceAllService

  def price
    stock = PriceService.new(params).call

    standard_response(stock)
  end

  def prices
    stocks = PricesService.new(params).call

    standard_response(stocks)
  end

  def price_all
    stocks = PriceAllService.new.call

    standard_response(stocks)
  end
end
