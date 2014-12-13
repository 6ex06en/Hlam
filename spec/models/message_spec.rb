require 'spec_helper'

describe Message do

it { should respond_to(:content)}
it { should respond_to(:user_id)}
it { should respond_to(:reciever_id)}
it { should respond_to(:read)}

let(:user) { FactoryGirl.create(:user) }
let(:other_user) { FactoryGirl.create(:user)}
let(:message) { FactoryGirl.create(:message, user: user, reciever_id: other_user.id)}

subject { message }

it "belongs to user" do
	message.user.should eq user
end

it "include all fields" do
	expect(message.content).to eq "New message"
end

it "read field should be default false" do
expect(message.read).to be_false
end

describe "should content size maximum 500" do
 before { message.content = "a" * 500 }
 it { should be_valid}

 it "size more then 500" do
 	message.content = "a" * 501
 	should_not be_valid
 end
end

describe "include all fields" do
	before { message.content = " "}
	it { should_not be_valid }
	before { message.reciever_id = nil}
	it { should_not be_valid }
end

describe "depends on the user" do
	before { user.destroy }
	it { expect(Message.where(user_id: user.id)).to be_empty }
end


it "after reading changes the status on readable"

end
