class BannersController < ApplicationController
  before_action :authorize!

  def index
    twitter = TwitterService.new(current_user)
    @friends = twitter.friends[:users]
  end
end
