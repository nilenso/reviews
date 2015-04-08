class Review < ActiveRecord::Base
  acts_as_commentable
  belongs_to :reviewer, class_name: User
  belongs_to :reviewee, class_name: User

  enum status: [:pending, :done]

  def grouped_comments
    self.comment_threads.decorate.group_by(&:parent_id)
  end
end
