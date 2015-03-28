module LoginSession
  extend ActiveSupport::Concern

  included do
    helper_method :current_user, :signed_in?
  end

  def current_user
    unless defined?(@current_user)
      @current_user = nil
      if user_id = current_user_id
        @current_user = User.find_by(id: user_id)
      end
    end
    @current_user
  end

  def signed_in?
    !!current_user
  end

  private

    def set_current_user_id(user_id)
      key         = SecureRandom.uuid
      secure_key  = SecureRandom.uuid

      session[key] = user_id
      session[secure_key] = user_id

      cookies.signed[:user_session] = {
        expires:  1.week.from_now,
        value:    key,
        httponly: true,
      }
      cookies.signed[:secure_user_session] = {
        expires:  1.week.from_now,
        value:    secure_key,
        httponly: true,
        secure:   true,
      }
    end

    def current_user_id
      cookie = request.ssl? ? :secure_user_session : :user_session
      key = cookies.signed[cookie]
      session[key]
    end
end
