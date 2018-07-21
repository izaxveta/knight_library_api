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
end