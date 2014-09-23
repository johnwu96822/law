class ChangeContentSizeInArticles < ActiveRecord::Migration
  def up
    change_column :articles, :content, :string, limit: 500
  end
  
  def down
  end
end
