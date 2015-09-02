module ApplicationHelper

  def bootstrap_class_for(flash_type)
    case flash_type
      when "info"
        "alert-info"
      when "alert"
        "alert-danger"
      when "warning"
        "alert-warning"
      when "notice"
        "alert-success"
      else
        flash_type.to_s
    end
  end

  def routesetter
    current_user && current_user.routesetter?
  end

  def admin
    current_user && current_user.admin?
  end

end
