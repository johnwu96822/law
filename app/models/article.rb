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
  acts_as_tree
end
