require 'spec_helper'

describe "Micropost pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "micropost creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a micropost" do
        expect { click_button "Post" }.not_to change(Micropost, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before { fill_in 'micropost_content', with: "Lorem ipsum" }
      it "should create a micropost" do
        expect { click_button "Post" }.to change(Micropost, :count).by(1)
      end
    end
  end


    describe "destroy_link"  do
      before do
      @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar") 
      @user.save 
      end

        describe "only current_user" do
      let(:user) { FactoryGirl.create(:user)}
      let!(:micropost) {FactoryGirl.create(:micropost, user: @user)}
        before do 
          sign_in user
          visit user_path(@user)
        end

        it {should_not have_link("destroy") }
        it {should have_content(@user.name)}
        it {should have_content(micropost.content)}
      end
    end
end