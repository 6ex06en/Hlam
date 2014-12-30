require 'spec_helper'

describe "Message pages" do

  subject { page }

let(:user) { FactoryGirl.create(:user)}
let(:other_user) { FactoryGirl.create(:user)}


describe "after reading message :reading should be changed" do
	before do 
		@message = user.messages.create(reciever_id: other_user.id, content: "123")
		sign_in other_user
		visit user_message_path(other_user, @message)
		visit user_messages_path(other_user)  
	end
	it { should have_content("Messages")}
	it { should have_content("following")}
	it { should have_content(@message.content)}
	it { should have_content(other_user.name)}
	it { should have_selector('li.read-true')}
end

end