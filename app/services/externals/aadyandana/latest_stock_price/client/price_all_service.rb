module Externals
  module Aadyandana
    module LatestStockPrice
      module Client
        class PriceAllService < DefaultService
          def initialize
            super()
          end

          def call
            ::Aadyandana::LatestStockPrice::Client.new(@api_key).price_all
          end
        end
      end
    end
  end
end
