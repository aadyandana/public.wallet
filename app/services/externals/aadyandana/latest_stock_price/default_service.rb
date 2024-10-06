module Externals
  module Aadyandana
    module LatestStockPrice
      class DefaultService
        def initialize
          @api_key = Rails.application.credentials.latest_stock_price_service[:api_key]
        end
      end
    end
  end
end
