class AddDescriptionToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :description, :text, after: :name
  end
end
