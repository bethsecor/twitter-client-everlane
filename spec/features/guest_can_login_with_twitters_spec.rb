require 'rails_helper'

RSpec.feature "GuestCanLoginWithTwitters", type: :feature do
  it "can authorize a user with their twitter account" do
    visit root_path

    VCR.use_cassette("twitter_service#banners") do
      click_on "Login with Twitter"

      expect(current_path).to eq('/banners')
      expect(page).to have_content("Twitter Banners for Miss Everlane")
    end
  end
end
