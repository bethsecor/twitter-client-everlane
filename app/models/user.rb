class User < ActiveRecord::Base
  def self.find_or_create_by_auth(auth)
    user = User.find_or_create_by(provider: auth['provider'], uid: auth['uid'])
    
    user.uid = auth['uid']
    user.name = auth['info']['name']
    user.nickname = auth['info']['nickname']
    user.token = auth['credentials']['token']
    user.secret = auth['credentials']['secret']

    user.save
    user
  end
end
