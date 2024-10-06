module Transactions
  class CreateService
    def initialize(params)
      @params = params
    end

    def call
      ActiveRecord::Base.transaction do
        session = Transaction.new(@params)

        session.save!

        session
      rescue ActiveRecord::ActiveRecordError => e
        raise e
      end
    end
  end
end
