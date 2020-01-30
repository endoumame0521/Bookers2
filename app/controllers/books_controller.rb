class BooksController < ApplicationController

  before_action :authenticate_user!

  def index
  	@books = Book.all
    @user = User.find(current_user.id)
  end

  def create
  	@book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have updated book successfully."
      redirect_to books_path
  	else
      index
      render 'index'
    end
  end

  def show
    @book = Book.find(params[:id])
    @user = User.find(@book.user_id)
    @comments = @book.comments
    @comment = Comment.new
    @favorites = @book.favorites
  end

  def edit
    @book = Book.find(params[:id])
    @user = User.find(@book.user_id)
    unless @user.id == current_user.id
      redirect_to books_path
    end

  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render 'edit'
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private
    def book_params
      params.require(:book).permit(:title, :body, tags_attributes: [:id, :name, :destroy])
    end
end