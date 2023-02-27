class CommentDecorator < Draper::Decorator
  delegate_all

  def markdown_text
    renderer = Redcarpet::Render::HTML.new
    markdown = Redcarpet::Markdown.new(renderer)
    markdown.render(model.body || "")
  end

  def render_with_children(commentable, all_comments)
    children = all_comments[self.id]
    buttons = [h.link_to("Reply", h.new_comment_path(commentable_id: commentable.id, commentable_type: commentable_type(commentable), parent_id: model.id), class: "comment-button btn btn-default btn-xs"),
               h.link_to("Edit", h.edit_comment_path(model, commentable_id: commentable.id, commentable_type: commentable_type(commentable)), class: "comment-button btn btn-default btn-xs"),
               h.link_to("Delete", h.comment_path(model, commentable_id: commentable.id, commentable_type: commentable_type(commentable)), method: :delete, data: {confirm: "Sure?"}, class: "comment-button btn btn-default btn-xs")].join
    author = h.content_tag(:span, "-- " + model.user.name, class: "comment-author")
    if children.present?
      children = children.map { |child| child.render_with_children(commentable, all_comments) }
      h.content_tag(:li, "".html_safe + h.content_tag(:div, self.markdown_text.html_safe, class: "comment") + author.html_safe + buttons.html_safe + h.content_tag(:ul, children.join.html_safe) )
    else
      h.content_tag(:li, "".html_safe + h.content_tag(:div, self.markdown_text.html_safe, class: "comment") + author.html_safe + buttons.html_safe)
    end
  end

  def commentable_type(commentable)
    commentable.class.to_s.downcase
  end
end
