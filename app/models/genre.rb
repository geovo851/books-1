class Genre < ActiveRecord::Base
  has_many :books_genres
  has_many :books, through: :books_genres

  validates :title, presence: true
end
