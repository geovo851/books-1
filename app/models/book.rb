class Book < ActiveRecord::Base
  belongs_to :user
  has_many :books_genres, dependent: :destroy
  has_many :genres, through: :books_genres
  accepts_nested_attributes_for :books_genres, allow_destroy: true

  validates :content, :title, :user_id, presence: true

  def self.all_books current_user
    if current_user
      if current_user.role == Role.find_or_create_by(title: 'admin')
        includes(:user, :genres)
      else
        where('(NOT books.draft) OR ((books.draft) AND (books.user_id = ?))', current_user.id)
      end
    else
      day = Time.now
      wday = day.wday == 0 ? 7 : day.wday
      monday = day - wday.days + 1.days
      includes(:user, :genres).where('NOT books.draft AND books.updated_at >= ?',
                                     monday.midnight)
    end
  end

  def self.search_books current_user, genre_id
    if current_user
      if current_user.role == Role.find_or_create_by(title: 'admin')
        joins(:user, :genres).where('genres.id = ?', genre_id)
      else
        joins(:genres).where('(NOT books.draft AND genres.id = ?) OR ((books.draft) AND books.user_id = ? AND genres.id = ?)',
                             genre_id, current_user.id, genre_id)
      end
    else
      day = Time.now
      wday = day.wday == 0 ? 7 : day.wday
      monday = day - wday.days + 1.days
      joins(:user, :genres).where('NOT books.draft AND books.updated_at >= ? AND genres.id = ?',
                                     monday.midnight, genre_id)
    end
  end
end
