class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :create, :login]
  skip_before_action :set_current_user, only: [:index, :create, :login]
  before_action :friend_auth, only: [:friend, :unfriend]

  # def index
  # end

  # def edit
  # end

  # def create
  #   @user = User.new(reg_params)
  #   if @user.save
  #     session[:user_id] = @user.id
  #     redirect_to home_path
  #   else
  #     flash[:error] = @user.errors.full_messages
  #     redirect_to root_path
  #   end
  # end

  # def login
  #   @user = User.find_by_username(params[:user][:username]).try(:authenticate, params[:user][:password])
  #   if @user
  #     session[:user_id] = @user.id
  #     redirect_to home_path
  #   else
  #     flash[:error] = ["Incorrect username or password"]
  #     redirect_to root_path
  #   end
  # end

  # def update
  #   flash[:error] = @user.errors.full_messages unless @user.update(edit_params)
  #   redirect_to home_path
  # end

  # def pw_change
  #   if @user.authenticate(params[:user][:old_password])
  #     flash[:error] = @user.errors.full_messages unless @user.update(pw_params)
  #   else
  #     flash[:error] = ["Incorrect password"]
  #   end
  #   redirect_to home_path
  # end

  # def logout
  #   session[:user_id] = nil
  #   redirect_to root_path
  # end

  def friend
    if params.include?(:id)
      @user.friends += [User.find(params[:id])]
    elsif params.include?(:username)
      @user.friends += [User.find_by(username: params[:username])]
    end
    redirect_to root_path
  end

  def unfriend
    @friend = User.find(params[:id])
    @user.friends.delete(@friend) if @user.friends.include?(@friend)
    @friend.friends.delete(@user) if @friend.friends.include?(@user)
    redirect_to root_path
  end

  private
  def reg_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
  def edit_params
    params.require(:user).permit(:name, :email)
  end
  def pw_params
    params.require(:user).permit(:password, :password_confirmation)
  end
  def friend_auth
    if params.include?(:id)
      redirect_to home_path unless User.exists?(id: params[:id]) && session[:user_id] != params[:id]
    else
      redirect_to home_path unless User.exists?(username: params[:username]) && @user.username != params[:username]
    end
  end
end
