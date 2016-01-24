class BooksController < ApplicationController
  filter_access_to :all
  before_action :set_genres, only: [:new, :edit, :create, :update]

  def show
    @book = Book.includes(:user, :genres).find(params[:id])
  end

  def new
    @book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id if current_user
    if @book.save
      flash[:success] = 'Book was successfully created.'
      redirect_to books_online_index_path
    else
      render 'new'
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:success] = 'Book was successfully updeted.'
      redirect_to books_online_index_path
    else
      render 'edit'
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_online_index_path
  end

  def change_draft
    @book = Book.find(params[:id])
    @book.draft = !@book.draft
    @book.save
  end

  private
    def book_params
      params.require(:book).permit(:user_id, :title, :photo, :content, :draft, 
                                   books_genres_attributes: [:id, :genre_id, :book_id, :_destroy])
    end

    def set_genres
      @genres = Genre.all
    end
end
