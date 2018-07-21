require 'rails_helper'

RSpec.describe('Book API') do
  it 'returns all books' do
    Book.create(title: 'Dead Until Dark', author: 'Charlaine Harris')
    Book.create(title: 'Club Dead', author: 'Charlaine Harris')
    Book.create(title: 'Dead as a Doornail', author: 'Charlaine Harris')

    get '/api/v1/books'

    content = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(Book.count).to eq(3)
    expect(content['book_count']).to eq(3)
    expect(content['books'].length).to eq(3)
    expect(content['books'].first['title']).to eq('Dead Until Dark')
    expect(content['books'].first['author']).to eq('Charlaine Harris')
  end

  it 'returns a single book' do
    book_1 = Book.create(title: 'Club Dead', author: 'Charlaine Harris')
    book_2 = Book.create(title: 'Dead as a Doornail', author: 'Charlaine Harris')

    get "/api/v1/books/#{book_2.id}"

    content = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(content['id']).to eq(book_2.id)
    expect(content['title']).to eq('Dead as a Doornail')
    expect(content['author']).to eq('Charlaine Harris')
  end

  it 'updates a single book given provided book parameters' do
    book_1 = Book.create(title: 'Club Dead', author: 'Charlaine Harris')
    book_2 = Book.create(title: 'Dead as a Doornail', author: 'Charlaine Harris')

    put "/api/v1/books/#{book_2.id}", params: { book: { title: 'Vampire Diaries' } }

    content = JSON.parse(response.body)
    updated_book_2 = Book.find(book_2.id)

    expect(response.status).to eq(202)
    expect(content['message']).to eq("Successfully updated book (id:#{book_2.id}).")
    expect(updated_book_2.title).to eq("Vampire Diaries")
  end

  it 'deletes a book' do
    book_1 = Book.create(title: 'Dead Until Dark', author: 'Charlaine Harris')
    book_2 = Book.create(title: 'Club Dead', author: 'Charlaine Harris')
    book_3 = Book.create(title: 'Dead as a Doornail', author: 'Charlaine Harris')

    expect(Book.count).to eq(3)

    delete "/api/v1/books/#{book_2.id}"

    content = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(content['message']).to eq("Successfully deleted book (id:#{book_2.id})")
    expect(Book.count).to eq(2)
  end
end