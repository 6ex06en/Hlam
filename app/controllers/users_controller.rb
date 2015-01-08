class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy, :following, :followers, :private_message]
  before_action :correct_user,   only: [:feed, :edit, :update, :all_messages]
  before_action :admin_user, only: [:destroy]
  after_action :send_confirm, only: [:create]

  def new
  redirect_to root_url if current_user
  @user = User.new
  end

  def feed
    @user = User.find_by(id: params[:id])
    @replies = @user.all_reply(order: "updated_at DESC", limit: 5)
    @relationships = @user.reverse_relationships
    @messages = @user.recieve_messages
    @followers = @user.followers 
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
    @user = User.new(user_params)  
    if @user.save
    @user.create_option
    @user.toggle!(:active)
    flash[:success] = "На ваш e-mail отправлено письмо о подтверждении регистрации" 
    redirect_to root_url
    #sign_in @user
    #flash[:success] = "Welcome to the Sample App!"
    #redirect_to @user
    else
      render 'new'
    end
  end

  def end_of_registration
      user = User.find_by(:remember_token => User.encrypt(params[:id]))
      if user && user.created_at > 5.day.ago
      user.toggle!(:active)
      sign_in user
      flash[:success] = "Пользователь активирован"
      redirect_to user
    else
      user.destroy if user
      flash[:error] = "Такой пользователь не существует"
      redirect_to signin_path
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

    def send_confirm
    remember_token = User.new_remember_token
    @user.update_attribute(:remember_token, User.encrypt(remember_token))
    UserMailer.send_confirm(@user, remember_token).deliver
    end

end

