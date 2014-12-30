class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy, :following, :followers, :private_message]
  before_action :correct_user,   only: [:edit, :update, :all_messages]
  before_action :admin_user, only: [:destroy]

  def new
  redirect_to root_url if current_user
  @user = User.new
  end

  def private_message
    @user = User.find(params[:user_id])
    @message = current_user.messages.build
  end

  def all_messages
    @user = User.find(params[:user_id])
    @messages = @user.recieve_messages.paginate(page: params[:page])
    @unread = @user.recieve_messages_unread
  end

  def index
  @users = User.paginate(page: params[:page])
  
  end

  def show
  @user = User.find(params[:id])
  @microposts = @user.only_mic.paginate(page: params[:page])
  end

  def edit
  end 

  def user_params_updates
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def update
    if @user.update_attributes(user_params)
    flash[:success] = "Profile updated"
    redirect_to @user
    else
    render 'edit'
    end
  end

  def create
    redirect_to root_url if current_user
    @user = User.new(user_params)    # Not the final implementation!
    if @user.save
    @user.create_option
    sign_in @user
    flash[:success] = "Welcome to the Sample App!"
    redirect_to @user
      # Handle a successful save.
    else
      render 'new'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end

