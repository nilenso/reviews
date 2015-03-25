class User < ActiveRecord::Base
  devise :rememberable, :trackable, :omniauthable, :omniauth_providers => [:google_oauth2]

  has_many :reviews_for, class_name: Review, foreign_key: :reviewee_id
  has_many :reviews_by, class_name: Review, foreign_key: :reviewer_id

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:email => data["email"]).first_or_initialize

    user.image = data["image"]
    user.name = data["first_name"]
    user.save

    user
  end

  def all_but_me
    User.where.not(id: self.id)
  end

  def reviews_pending_for
    Review.pending.where(reviewee: self)
  end

  def reviews_done_for
    Review.done.where(reviewee: self)
  end
end
