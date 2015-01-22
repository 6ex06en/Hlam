class MicropostsController < ApplicationController
  before_action :signed_in_user
  before_action :correct_user, only: [:destroy]

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def show
    @micropost = Micropost.find(params[:id])
    @user = @micropost.user
    @reps = @user.all_reply
  end

  def reply
    @micropost = current_user.microposts.build(reply_params)
    if @micropost.save
      redirect_to micropost_path(params[:micropost][:including_replies])
    else
      redirect_to root_url
    end
  end

  def destroy
    @micropost.destroy
    redirect_to root_url
  end

  def search
  @result = Micropost.search(params[:search]).paginate(page: params[:page])
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content)
    end

    def reply_params
      params.require(:micropost).permit(:content, :in_reply_to, :including_replies)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end

end
