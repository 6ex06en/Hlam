require 'spec_helper'

describe "User pages" do
	let(:submit) {'Create my account'}

	subject {page}

  describe "signup page" do
    before { visit signup_path }

 it { should have_content('Sign up') }
 it { should have_title(full_title('Sign up')) }
  end

  describe "After signup(should have error)" do
  	before { visit signup_path }
  	before { click_button submit }

  	it {should have_content('errors')}
  	it {should have_title('Sign')}
end
	describe "After signup(All right)" do
		before { visit signup_path }

		before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

  		before { click_button submit }

			it {should have_title('| Example User')}
			it {should have_content('Welcome to the Sample App!')}
end

	describe "after saving the user" do
		before { visit signup_path }
		before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }
        

        it { should have_title(user.name) }
        it { should have_selector('div', text: 'Welcome') }
      end
end