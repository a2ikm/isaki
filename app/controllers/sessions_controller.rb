class SessionsController < ApplicationController
  def new
    @login = Login.new
  end

  def create
    @login = Login.new(login_params)

    user = @login.authenticate!
    reset_session
    set_current_user_id(user.id)

    redirect_to posts_url

  rescue Isaki::LoginFailed
    render :new
  end

  def destroy
    delete_current_user_id

    redirect_to posts_url
  end

  private

    def login_params
      params.require(:login).permit(:email, :password)
    end
end
