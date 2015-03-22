class AddNameUniqueIndexOnPosts < ActiveRecord::Migration
  def change
    add_index :posts, :name, unique: true
  end
end
