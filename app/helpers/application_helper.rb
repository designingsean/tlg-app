module ApplicationHelper
  def flash_class(level)
    case level.to_s
      when "notice", "success" then "success"
      when "warning" then "warning"
      when "error", "alert" then "danger"
    end
  end
end
