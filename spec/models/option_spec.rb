require 'spec_helper'

describe Option do

let(:user) { FactoryGirl.create(:user)}
let(:other_user) { FactoryGirl.create(:user)}
let(:option) { user.create_option(email_notice: true)}

it "should respond to all request" do
	should respond_to(:email_notice)
end
it "should belong model user" do
	expect(option.user).to eq user
end

describe "should dependent at model user and to have validation" do
	subject { option }
	before { option.email_notice = "" }
	it "checking dependencies" do
		should_not be_valid
	end

	it "no user - no option" do
	expect { user.destroy }.to change(Option, :count).by(-1)
	end
end
end