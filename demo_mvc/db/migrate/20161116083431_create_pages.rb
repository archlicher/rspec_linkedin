class CreatePages < ActiveRecord::Migration[5.0]
  def change
    create_table :pages do |t|
      t.integer :subject_id
      t.string :name, :limit => 25
      t.integer :permalink
      t.integer :position
      t.boolean :visible, :default => false

      t.timestamps
    end

    add_index :pages, :permalink
    add_index :pages, :subject_id
    add_foreign_key :pages, :subjects
  end
end
