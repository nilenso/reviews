module ApplicationHelper
  def is_active?(link_path)
    current_page?(link_path) ? "active" : ""
  end

  def flash_class(level)
    case level
    when :notice then "alert-info"
    when :error then "alert-danger"
    when :alert then "alert-warning"
    end
  end
end
