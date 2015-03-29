class SessionsController < ApplicationController
  def new
    @login = Login.new(original_url: params[:original_url])
  end

  def create
    @login = Login.new(login_params)

    user = @login.authenticate!
    reset_session
    set_current_user_id(user.id)

    redirect_to sanitize_url(@login.original_url) || posts_url

  rescue Isaki::LoginFailed
    render :new
  end

  def destroy
    delete_current_user_id

    redirect_to posts_url
  end

  private

    def login_params
      params.require(:login).permit(:login_or_email, :password, :original_url)
    end

    def sanitize_url(url)
      URI.parse(url).host == request.host ? url : nil
    rescue
      nil
    end
end
