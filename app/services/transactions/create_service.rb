module Transactions
  class CreateService
    def initialize(params)
      @params = params
    end

    def call
      ActiveRecord::Base.transaction do
        transaction = Transaction.new(@params)

        transaction.save!

        transaction
      rescue ActiveRecord::ActiveRecordError => e
        raise e
      end
    end
  end
end
