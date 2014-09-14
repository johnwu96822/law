class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :content
      t.string :ancestry
      t.integer :priority, default: 0
      t.integer :user_id

      t.timestamps
    end
    add_index :articles, :ancestry
  end
end
