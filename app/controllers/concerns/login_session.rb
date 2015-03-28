module LoginSession
  extend ActiveSupport::Concern

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
end
