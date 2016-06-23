require 'rails_helper'

RSpec.feature "GuestCanLoginWithTwitters", type: :feature do
  it "can authorize a user with their twitter account" do
    visit root_path

    click_on "Login with Twitter"

    expect(current_path).to eq('/banners')
    expect(page).to have_content("Bird Banners for Miss Everlane")
  end
end
