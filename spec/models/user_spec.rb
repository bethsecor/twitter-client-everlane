require 'rails_helper'

RSpec.describe User, type: :model do
  it "should return a user given auth data" do
    data = {
      'provider' => 'twitter',
      'uid' => '123456',
      'info' => {
        'name' => 'Miss Capybara',
        'nickname' => 'miss.capybara',
        'location' => 'Denver, CO'
      },
      'credentials' => { 'token' => 'hshrhrlahlrahlhtl',
                        'secret' => 'gjlgjy40sgk3l45ll2ltl6'}
    }

    user = User.find_or_create_by_auth(data)

    expect(user.uid).to eq '123456'
    expect(user.name).to eq 'Miss Capybara'
    expect(user.nickname).to eq 'miss.capybara'
    expect(user.token).to eq 'hshrhrlahlrahlhtl'
    expect(user.secret).to eq 'gjlgjy40sgk3l45ll2ltl6'
  end
end
