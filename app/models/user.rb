class User < ActiveRecord::Base
  attr_accessor :password

  validates :email,     presence: true, uniqueness: true
  validates :password,  on: :create,
                        presence: true,
                        length: { within: 8..40 },
                        confirmation: true
  validates :password,  on: :update,
                        length: { within: 8..40 },
                        confirmation: true
  validates :password_confirmation, presence: true, if: ->(user) { user.password.present? }

  before_save :reset_password_salt_and_digest, if: ->(user) { user.password.present? }

  def self.generate_password_digest(password, password_salt)
    iterations = 20030
    key_len    = 16
    algorithm  = OpenSSL::Digest::SHA512.new

    digest_bytes = OpenSSL::PKCS5.pbkdf2_hmac(
      password,
      password_salt,
      iterations,
      key_len,
      algorithm
    )

    digest_bytes.unpack("H*").first
  end

  private

    def reset_password_salt_and_digest
      self.password_salt   = SecureRandom.hex(16)
      self.password_digest = self.class.generate_password_digest(password, password_salt)
    end
end
