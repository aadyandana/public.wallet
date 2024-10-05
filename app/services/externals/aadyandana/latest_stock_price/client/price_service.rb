module Externals
  module Aadyandana
    module LatestStockPrice
      module Client
        class PriceService < DefaultService
          def initialize(params)
            super()

            @params = {
              identifier: params[:identifier],
              symbol: params[:symbol],
              company_name: params[:company_name],
              industry: params[:industry],
              isin: params[:isin]
            }
          end

          def call
            ::Aadyandana::LatestStockPrice::Client.new(@api_key, @params).price
          end
        end
      end
    end
  end
end
