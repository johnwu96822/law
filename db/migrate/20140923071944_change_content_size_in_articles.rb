class ChangeContentSizeInArticles < ActiveRecord::Migration
  def up
    change_column :articles, :content, :text
  end
  
  def down
  end
end
