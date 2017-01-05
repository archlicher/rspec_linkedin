class CreateSections < ActiveRecord::Migration[5.0]
  def change
    create_table :sections do |t|
      t.integer :page_id
      t.string :name, :limit => 25
      t.integer :position
      t.boolean :visible, :default => false
      t.string :content_type, :limit => 25
      t.text :content

      t.timestamps
    end

    add_index :sections, :page_id
    add_foreign_key :sections, :pages
  end
end
