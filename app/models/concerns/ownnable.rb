module Ownnable
  extend ActiveSupport::Concern
  
  included do
    belongs_to :user
  end
  
  def owner?(user)
    self.user_id == user.id
  end
end