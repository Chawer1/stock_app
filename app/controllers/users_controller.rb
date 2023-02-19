# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to action: 'index'
    else
      render 'new'
    end
  end

  def login; end

  def authenticate
    user = User.find_by_email(params[:email])
    if user&.authenticate(params[:password_digest])
      session[:user_id] = user.id
      redirect_to action: 'index'
    else
      flash[:alert] = 'Invalid email or password'
      render 'login'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password_digest)
  end
end
