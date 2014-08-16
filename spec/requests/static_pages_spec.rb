require 'spec_helper'

describe "Static pages" do

  describe "Home page" do

    it "should have the content 'Second App'" do
      visit '/static_pages/home'
      expect(page).to have_content('Second App')
    end
    it "should have the title 'Home'" do
      visit '/static_pages/home'
      expect(page).to have_title("Ruby on Rails Tutorial Second App | Home")
    end
  end


describe "Help page" do

    it "should have the content 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_content('Help')
    end
    it "should have the title 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_title("Ruby on Rails Tutorial Second App | Help")
    end
  end
describe "About page" do

    it "should have the content 'About Us'" do
      visit '/static_pages/about'
      expect(page).to have_content('About Us')
    end
    it "should have the title 'About Us'" do
      visit '/static_pages/about'
      expect(page).to have_title("Ruby on Rails Tutorial Second App | About Us")
    end
  end

  describe "Contact page" do

    it "should have the content 'Second App'" do
      visit '/static_pages/contact'
      expect(page).to have_content('Kerz')
    end
    it "should have the title 'Contact'" do
      visit '/static_pages/contact'
      expect(page).to have_title("Ruby on Rails Tutorial Second App | Contact")
    end
  end
end