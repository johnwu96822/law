module Permission
  extend ActiveSupport::Concern
  
  def owner_and_admin_only(obj_with_user)
    if !obj_with_user.owner?(current_user) && !admin?
      if block_given?
        yield
      end
      return false
    end
    true
  end

end