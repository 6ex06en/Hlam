class MessagesController < ApplicationController
	before_action :correct_user, only: [:index]

def create
	@message = current_user.messages.build(require_params)
	@user = User.find(params[:message][:reciever_id])
	if @message.save
		flash[:success] = "Message sent!"
		redirect_to @user
	else
		render "users/private_message"
	end
end

def index
    @user = User.find(params[:user_id])
    @messages = @user.recieve_messages.paginate(page: params[:page])
    @unread = @user.recieve_messages_unread
end


def destroy
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

end
