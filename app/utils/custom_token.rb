class CustomToken
  def initialize(plaindata)
    @secret = Rails.application.credentials[:custom_token_secret]

    @plaindata = plaindata
  end

  def call
    encryptor = ActiveSupport::MessageEncryptor.new(@secret)

    encryptor.encrypt_and_sign(@plaindata)
  end
end
