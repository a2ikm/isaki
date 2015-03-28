class Login
  include ActiveModel::Model

  attr_accessor :email, :password, :original_url

  def authenticate!
    user = User.find_by(email: email)
    raise Isaki::LoginFailed if user.nil?

    if user.verify_password(password)
      user
    else
      raise Isaki::LoginFailed
    end
  end
end
