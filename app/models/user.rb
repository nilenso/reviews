class User < ActiveRecord::Base
  acts_as_commentable
  validates :salary, numericality: true
  validates :level, numericality: true
  devise :rememberable, :trackable, :omniauthable, :omniauth_providers => [:google_oauth2]

  has_many :reviews_for, class_name: Review, foreign_key: :reviewee_id
  has_many :reviews_by, class_name: Review, foreign_key: :reviewer_id

  def self.find_for_google_oauth2(access_token, signed_in_resource = nil)
    data = access_token.info
    user = User.where(:email => data['email']).first_or_initialize

    user.image = data['image']
    user.name = data['first_name']
    user.salary = 0
    user.level = 0
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

  def only_full_reviews_done_for
    Review.done.where(reviewee: self, is_level_only: false)
  end

  def only_review_levels_done_for
    Review.done.where(reviewee: self, is_level_only: true)
  end

  def needs_to_write_reviews_for
    Review.pending.where(reviewer: self)
  end

  def average_suggested_level
    self.reviews_for.done.average(:suggested_level)
  end

  def can_view_average_suggested_level_for_user?(user)
    pending_reviews_for = self.reviews_by.pending.pluck(:reviewee_id)
    !pending_reviews_for.include?(user.id)
  end

  def grouped_comments
    self.comment_threads.decorate.group_by(&:parent_id)
  end
end
