class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.save!

    redirect_to posts_url

  rescue ActiveRecord::RecordInvalid => e
    render :new
  end

  private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
