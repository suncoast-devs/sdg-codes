class User < ApplicationRecord
  has_many :links

  def self.from_auth_hash(auth)
    return unless auth.info.email =~ /@suncoast.io$/
    where(uid: auth.uid).first_or_initialize.tap do |user|
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.save!
    end
  end

  def self.from_api_key(token)
    where(email: User.encryptor.decrypt_and_verify(token)).first
  end

  def api_key
    User.encryptor.encrypt_and_sign(email)
  end

  def self.encryptor
    @encryptor ||= ActiveSupport::MessageEncryptor.new(
      Rails.application.credentials.api_token_key
    )
  end
end
