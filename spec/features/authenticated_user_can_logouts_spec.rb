require 'rails_helper'

RSpec.feature "AuthenticatedUserCanLogouts", type: :feature do
  it "can logout an authenticated user" do
    visit root_path

    VCR.use_cassette("twitter_service#banners") do
      click_on "Login with Twitter"

      expect(current_path).to eq(banners_path)
      expect(page).to have_link('Logout')

      click_on 'Logout'
    end

    expect(current_path).to eq(root_path)

    visit banners_path

    expect(current_path).to eq(root_path)
  end
end
