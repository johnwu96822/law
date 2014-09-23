# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  content    :string(255)
#  ancestry   :string(255)
#  priority   :integer
#  created_at :datetime
#  updated_at :datetime
#

class Article < ActiveRecord::Base
  include Ownnable
  # Ancestry would not allow empty string "" as ancestry field.
  # ancestry needs to be nil for root nodes
  has_ancestry orphan_strategy: :adopt
  
  validates :content, presence: true, length: {maximum: 255}
end
