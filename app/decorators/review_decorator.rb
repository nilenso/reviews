class ReviewDecorator < Draper::Decorator
  delegate_all

  def markdown_text
    renderer = Redcarpet::Render::HTML.new
    markdown = Redcarpet::Markdown.new(renderer)
    markdown.render(model.text || "")
  end
end
