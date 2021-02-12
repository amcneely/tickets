class CreateTags < ActiveRecord::Migration[6.0]
  def change
    create_table :tags do |t|
      t.string :name, null: false
      t.integer :ticket_count, null: false, default: 0

      t.timestamps
    end
    add_index :tags, :name
    add_index :tags, :ticket_count
  end
end
