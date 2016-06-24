class TwitterService
  attr_reader :connection, :user

  def initialize(user)
    @user = user
    @connection = Faraday.new(url: "https://api.twitter.com/")
  end

  def friends
    response = connection.get do |req|
      req.url '1.1/friends/list.json'
      req.params['count'] = '200'
      req.params['cursor'] = '-1'
      req.params['include_user_entities'] = 'false'
      req.params['skip_status'] = 'true'
      req.params['user_id'] = user.uid
      req.headers['Authorization'] = friend_header_string
    end
    parsed_response = parse(response)
    parsed_response[:users] ? parsed_response[:users] : []
  end

  def friend_header_string
    header = "OAuth "
    friend_header.each do |k, v|
      header += "#{k}=\"#{v}\", "
    end
    header.slice(0..-3)
  end

  def friend_header
    oauth_timestamp = timestamp
    oauth_nonce = nonce
    {
      oauth_consumer_key: ENV["TWITTER_ID"],
      oauth_nonce: oauth_nonce,
      oauth_signature: friends_signature(oauth_timestamp, oauth_nonce),
      oauth_signature_method: "HMAC-SHA1",
      oauth_timestamp: oauth_timestamp,
      oauth_token: user.token,
      oauth_version: "1.0"
    }
  end

  private

    def parse(response)
      JSON.parse(response.body, symbolize_names: true)
    end

    def timestamp
      Time.now.to_i.to_s
    end

    def nonce
      SecureRandom.hex
    end

    def friends_signature(timestamp, nonce)
      digest = OpenSSL::Digest.new('sha1')
      hmac = OpenSSL::HMAC.digest(digest, signing_key, friends_base_string(timestamp, nonce))
      CGI.escape(Base64.encode64(hmac).chomp.gsub(/\n/, ''))
    end

    def friends_base_string(timestamp, nonce)
      http_method = "GET"
      base_url = "https://api.twitter.com/1.1/friends/list.json"
      parameters = "count=200" + "&" +
                   "cursor=-1" + "&" +
                   "include_user_entities=false" + "&" +
                   "oauth_consumer_key=#{ENV["TWITTER_ID"]}" + "&" +
                   "oauth_nonce=#{nonce}" + "&" +
                   "oauth_signature_method=HMAC-SHA1" + "&" +
                   "oauth_timestamp=#{timestamp}" + "&" +
                   "oauth_token=#{user.token}" + "&" +
                   "oauth_version=1.0" + "&" +
                   "skip_status=true" + "&" +
                   "user_id=#{user.uid}"
      http_method + "&" + CGI.escape(base_url) + "&" + CGI.escape(parameters)
    end

    def signing_key
      CGI.escape(ENV["TWITTER_SECRET"]) + "&" + CGI.escape(user.secret)
    end
end
