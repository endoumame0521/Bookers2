class CommentsController < ApplicationController
  def create
  	book = Book.find(params[:book_id])
  	comment = Comment.new(comment_params)
  	comment.user_id = current_user.id
  	comment.book_id = book.id
  	if comment.save
  	  flash[:notice] = "You have updated comment successfully."
  	  redirect_to book_path(book.id)
  	else
  	  redirect_to book_path(book.id)
  	end
  end

  def edit
  	@comment = Comment.find(params[:id])
  	@book = Book.find(params[:book_id])
  	unless @comment.user_id == current_user.id
  	  redirect_to book_path(@book.id)
  	end
  end

  def update
  	@comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      flash[:notice] = "You have updated comment successfully."
      redirect_to book_path(@comment.book_id)
    else
  	  @book = Book.find(params[:book_id])
      render 'edit'
    end
  end

  def destroy
  	comment = Comment.find(params[:id])
  	comment.destroy
  	redirect_to book_path(comment.book_id)
  end

  private
  def comment_params
  	params.require(:comment).permit(:user_id, :book_id, :comment)
  end
end