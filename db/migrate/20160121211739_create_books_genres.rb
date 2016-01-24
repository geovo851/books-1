class CreateBooksGenres < ActiveRecord::Migration
  def change
    create_table :books_genres do |t|
      t.references :book, index: true, foreign_key: true
      t.references :genre, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
