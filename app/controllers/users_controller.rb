class UsersController < ApplicationController
  include LoginCookies

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.save!

    reset_session
    set_current_user_id(@user.id)

    redirect_to posts_url

  rescue ActiveRecord::RecordInvalid => e
    render :new
  end

  private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
