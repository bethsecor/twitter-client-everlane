require 'rails_helper'

RSpec.feature "AuthenticatedUserSeesFriendsBanners", type: :feature do
  it "can see their friend's banners" do
    user = User.create({
      :provider => 'twitter',
      :uid => '961818270',
      :name => 'Miss Everlane',
      :nickname => 'miss.everlane',
      :token => ENV['TWITTER_TOKEN'],
      :secret => ENV['TWITTER_SECRET_TOKEN']
    })
    ApplicationController.any_instance.stubs(:current_user).returns(user)

    VCR.use_cassette("twitter_service#banners_2") do
      visit banners_path
      expect(current_path).to eq('/banners')

      friends = Friend.get_friends(user)

      friends.each do |friend|
        within("#friend-#{friend.id}") do
          expect(page).to have_css('img')
          expect(page).to have_css("img[src*='#{friend.profile_banner_url}']")
        end
      end
    end
  end
end
