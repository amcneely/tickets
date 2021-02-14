class AddUniqueConstraintToTagsNameIndex < ActiveRecord::Migration[6.0]
  def change
    remove_index :tags, :name
    add_index :tags, :name, unique: true
  end
end
