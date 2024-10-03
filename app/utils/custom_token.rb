class CustomToken
  def initialize(plaindata)
    @plaindata = plaindata
  end

  def call
    secret = "04990bbe1e9f8388207bbd63ca0967ca"
    encryptor = ActiveSupport::MessageEncryptor.new(secret)

    encryptor.encrypt_and_sign(@plaindata)
  end
end
