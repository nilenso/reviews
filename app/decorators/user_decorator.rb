class UserDecorator < Draper::Decorator
  delegate_all

  def username
    model.name || model.email
  end

  def needs_reviews_from
    names = user.reviews_pending_for.map do |review|
      review.reviewer.decorate.username
    end
    names.to_sentence.presence || 'no one'
  end

  def got_reviews_from
    names = user.only_full_reviews_done_for.map do |review|
      h.link_to review.reviewer.decorate.username, h.user_review_path(h.current_user, review.id)
    end

    names.to_sentence.presence || 'no one'
  end

  def got_levels_from
    names = user.only_review_levels_done_for.map do |review|
      h.link_to review.reviewer.decorate.username, h.user_review_path(h.current_user, review.id)
    end

    names.to_sentence.presence || 'no one'
  end

  def needs_to_write_reviews_for
    names = user.needs_to_write_reviews_for.map do |review|
      h.link_to review.reviewee.decorate.username, h.edit_user_review_path(user, review)
    end

    names.to_sentence.presence
  end

  def salary_in_lakhs
    "#{user.salary / 100000}L"
  end

  def render_comments
    grouped_comments = self.grouped_comments
    h.content_tag(:ul, grouped_comments[nil].map { |comment| comment.render_with_children(model, grouped_comments) }.join.html_safe)
  end
end
