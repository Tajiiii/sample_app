class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    #&& (論理積 (and)) は、取得したユーザーが有効かどうかを決定するために使う
    #ユーザーがデータベースにあり、かつ、認証に成功した場合にのみ
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
