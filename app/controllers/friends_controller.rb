class FriendsController < ApplicationController
  before_action :authorize!

  def index
    @friends = Friend.get_friends(current_user)
  end
end
