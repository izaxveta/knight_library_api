require 'rails_helper'

RSpec.describe 'Book' do
  context 'invalid attributes' do
    it 'is invalid without a title' do
      book = Book.create(author: 'J.K. Rowling')
      expect(book).to be_invalid
    end

    it 'is invalid without an author' do
      book = Book.create(title: "Harry Potter and the Sorcerer's Stone")
      expect(book).to be_invalid
    end

    it 'cannot have duplicate titles associated under the same author' do
      Book.create(title: "Harry Potter", author: "J.K. Rowling")
      invalid_book = Book.create(title: "Harry Potter", author: "J.K. Rowling")
      invalid_book_2 = Book.create(title: "harry potter", author: "J.K. Rowling")
      valid_book = Book.create(title: "Harry Potter", author: "Margaret Mitchell")

      expect(invalid_book).to be_invalid
      expect(invalid_book_2).to be_invalid
      expect(valid_book).to be_valid
    end
  end

  context 'valid attributes' do
    it 'is valid with both a title and author' do
      book = Book.create(title: "Harry Potter", author: "J.K. Rowling")
      expect(book).to be_valid
    end
  end
end