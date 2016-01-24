class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.references :user, index: true, foreign_key: true
      t.string :title
      t.string :photo
      t.string :photo_orig
      t.text :content
      t.boolean :draft, default: false

      t.timestamps null: false
    end
  end
end
