class UserSessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to projects_url, notice: "Logged in!"
    else
      flash[:notice] = "Error: username and password provided are incorrect."
      render "new"
      flash.clear
      params[:email].clear
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'Logged out!'
    flash.clear
  end
end
