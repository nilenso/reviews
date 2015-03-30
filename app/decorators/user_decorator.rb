class UserDecorator < Draper::Decorator
  delegate_all

  def username
    model.name || model.email
  end

  def needs_reviews_from
    names = user.reviews_pending_for.map do |review|
      review.reviewer.decorate.username
    end
    names.to_sentence.presence || "no one"
  end

  def got_reviews_from
    names = user.reviews_done_for.map do |review|
      h.link_to review.reviewer.decorate.username, h.user_review_path(h.current_user, review.id)
    end

    names.to_sentence.presence || "no one"
  end

  def salary_in_lakhs
    "#{user.salary / 100000}L"
  end
end
