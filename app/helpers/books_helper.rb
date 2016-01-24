module BooksHelper

  def all_genres genres
    genres_title = ''
    genres.each do |genre|
      genres_title += ', ' unless genres_title == ''
      genres_title += genre.title
    end
    genres_title
  end

  def title_link_draft book
    book.draft ? 'Remove from draft' : 'Add to draft'
  end
end
