class BooksOnlineController < ApplicationController
  filter_access_to :all
  before_action :set_genres, only: [:search_books, :index]

  def index
    @books = Book.all_books(current_user).page(params[:page]).per(5)
  end

  def search_books
    @books = Book.search_books(current_user, params[:id]).page(params[:page]).per(5)
    @genre_title = Genre.find(params[:id]).title
    @genre_id = "genre_#{params[:id]}"
  end

  def about
  end

  def contact
  end

  private
    def set_genres
      @genres = Genre.all
    end
end
