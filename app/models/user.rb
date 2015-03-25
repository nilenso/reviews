class User < ActiveRecord::Base
  devise :rememberable, :trackable, :omniauthable, :omniauth_providers => [:google_oauth2]

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:email => data["email"]).first_or_initialize

    user.image = data["image"]
    user.name = data["name"]
    user.save

    user
  end
end
