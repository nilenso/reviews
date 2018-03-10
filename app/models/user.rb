class User < ActiveRecord::Base
  acts_as_commentable
  validates :salary, numericality: true
  validates :level, numericality: true
  devise :rememberable, :trackable, :omniauthable, :omniauth_providers => [:google_oauth2]

  has_many :reviews_for, class_name: Review, foreign_key: :reviewee_id
  has_many :reviews_by, class_name: Review, foreign_key: :reviewer_id

  def self.find_for_google_oauth2(access_token, _ = nil)
    data = access_token.info
    user = User.where(:email => data['email']).first_or_initialize(new_user_params(data))
    user.save
    user
  end

  def self.new_user_params(data)
    {
        image: data['image'],
        name: data['first_name'],
        salary: 0,
        level: 0
    }
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

  def needs_to_write_reviews_for
    Review.pending.where(reviewer: self)
  end

  def only_full_reviews_done_for
    Review.done.where(reviewee: self, is_level_only: false)
  end

  def only_review_levels_done_for
    Review.done.where(reviewee: self, is_level_only: true)
  end

  def average_suggested_level
    self.reviews_for.done.average(:suggested_level)
  end

  def stdev_suggested_level
    suggested_level = self.reviews_for.done.map(&:suggested_level)
    suggested_level.stdev if suggested_level.present? && suggested_level.count > 1
  end

  def can_view_suggested_level_for_user?(user)
    pending_reviews_for = self.reviews_by.pending.pluck(:reviewee_id)
    !pending_reviews_for.include?(user.id)
  end

  def grouped_comments
    self.comment_threads.decorate.group_by(&:parent_id)
  end
end
