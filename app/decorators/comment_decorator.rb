class CommentDecorator < Draper::Decorator
  delegate_all

  def markdown_text
    renderer = Redcarpet::Render::HTML.new
    markdown = Redcarpet::Markdown.new(renderer)
    markdown.render(model.body || "")
  end

  def render_with_children(review, all_comments)
    children = all_comments[self.id]
    buttons = [h.link_to("Reply", h.new_review_comment_path(review, parent_id: model.id), class: "comment-button btn btn-default btn-xs"),
               h.link_to("Edit", h.edit_review_comment_path(review, model), class: "comment-button btn btn-default btn-xs")].join
    if children.present?
      children = children.map { |child| child.render_with_children(review, all_comments) }
      h.content_tag(:li, "".html_safe + h.content_tag(:div, self.markdown_text.html_safe, class: "comment") + buttons.html_safe + h.content_tag(:ul, children.join.html_safe) )
    else
      h.content_tag(:li, "".html_safe + h.content_tag(:div, self.markdown_text.html_safe, class: "comment") + buttons.html_safe)
    end
  end
end
