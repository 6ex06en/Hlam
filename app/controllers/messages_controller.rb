class MessagesController < ApplicationController
	before_action :correct_user, only: [:index]
	before_action :own_messages, only: [:show, :destroy]

def create
	@message = current_user.messages.build(require_params)
	if @message.save
		flash[:success] = "Message sent!"
		redirect_to current_user
	else
		render "users/private_message"
	end
end

def index
    @user = User.find(params[:user_id])
    @messages = @user.recieve_messages.paginate(page: params[:page], per_page: 10)
    @unread = @user.recieve_messages_unread
end


def destroy
	@user = User.find(params[:user_id])
	current_user.recieve_messages.find(params[:id]).destroy
	redirect_to user_messages_path(current_user)
end

def show
	@user = User.find(params[:user_id])
	@message = Message.find(params[:id])
	@message.update_attributes(read: true) if @message.read == false 
end

private

def require_params
	params.require(:message).permit(:content, :reciever_id)
end

def correct_user
      @user = User.find(params[:user_id])
      redirect_to(root_url) unless current_user?(@user)
end

def own_messages
	redirect_to user_path(current_user) unless Message.find(params[:id]).reciever_id == current_user.id 
end

end
