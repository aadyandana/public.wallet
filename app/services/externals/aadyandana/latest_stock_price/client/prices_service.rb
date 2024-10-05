module Externals
  module Aadyandana
    module LatestStockPrice
      module Client
        class PricesService < DefaultService
          def initialize(params)
            super()

            @params = {
              page: params[:page],
              limit: params[:limit],
              identifier: params[:identifier],
              symbol: params[:symbol],
              company_name: params[:company_name],
              industry: params[:industry],
              isin: params[:isin]
            }
          end

          def call
            ::Aadyandana::LatestStockPrice::Client.new(@api_key, @params).prices
          end
        end
      end
    end
  end
end
