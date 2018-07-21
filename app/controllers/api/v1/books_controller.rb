class Api::V1::BooksController < ApplicationController
  def index
    books = Book.all
    render status: 200, json: {
      book_count: books.count,
      books: books
    }
  end

  def show
    book = Book.find(params[:id])
    render status: 200, json: book
  end

  def update
    book = Book.find(params[:id])
    if book.update(book_params)
      render status: 202, json: {
        message: "Successfully updated book (id:#{book.id})."
      }
    else
      render status: 400, json: {
        message: "Something happened and your request could not be fulfilled, please check yourself."
      }
    end
  end

  private

    def book_params
      params.require(:book).permit(:title, :author)
    end
end