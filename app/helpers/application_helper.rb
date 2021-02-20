module ApplicationHelper
  def notification_class(type)
    case type
    when "notice"
      "is-info"
    when "alert"
      "is-danger"
    end
  end
end
