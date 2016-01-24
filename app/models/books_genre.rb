class BooksGenre < ActiveRecord::Base
  belongs_to :book
  belongs_to :genre

  validates :genre_id, presence: true
end
