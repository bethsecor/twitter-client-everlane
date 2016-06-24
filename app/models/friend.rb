class Friend
  def self.service(current_user)
    TwitterService.new(current_user)
  end

  def self.get_friends(current_user)
    friends_json = service(current_user).friends
    friends = friends_json.map do |friend|
      build_object(friend)
    end
    friends.select { |friend| friend[:profile_banner_url] }
  end

  private

    def self.build_object(data)
      OpenStruct.new(data)
    end
end
