class ReviewDecorator < Draper::Decorator
  delegate_all

  def markdown_text
    renderer = Redcarpet::Render::HTML.new
    markdown = Redcarpet::Markdown.new(renderer)
    markdown.render(model.text || "")
  end

  def render_comments
    grouped_comments = self.grouped_comments
    h.content_tag(:ul, grouped_comments[nil].map { |comment| comment.render_with_children(model, grouped_comments) }.join.html_safe)
  end
end
