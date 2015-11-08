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

  def correct_current_user(user_id = nil)
    User.find_by(:id=>user_id) == current_user || current_user.admin?
  end

  def full_title(page_title = '')
    base_title = "Climbing Route Database"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
end
