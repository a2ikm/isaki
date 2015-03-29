class Login
  include ActiveModel::Model

  attr_accessor :login_or_email, :password, :original_url

  def authenticate!
    user = User.find_by_login_or_email(login_or_email)
    raise Isaki::LoginFailed if user.nil?

    if user.verify_password(password)
      user
    else
      raise Isaki::LoginFailed
    end
  end
end
