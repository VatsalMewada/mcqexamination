# frozen_string_literal: true

# Application helper
module ApplicationHelper
  def put_sidebar
    if user_signed_in?
      if current_user.has_role? :admin
        concat(render(partial: 'layouts/admin_header'))
      elsif current_user.has_role? :faculty
        concat(render(partial: 'layouts/faculty_header'))
      end
    end
  end
end
