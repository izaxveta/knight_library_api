require 'rails_helper'

RSpec.describe('Book API') do
  it('returns all books') do
    Book.create(title: 'Dead Until Dark', author: 'Charlaine Harris')
    Book.create(title: 'Club Dead', author: 'Charlaine Harris')
    Book.create(title: 'Dead as a Doornail', author: 'Charlaine Harris')

    get '/api/v1/books'

    content = JSON.parse(response.body)

    expect(Book.count).to eq(3)
    expect(content['book_count']).to eq(3)
    expect(content['books'].length).to eq(3)
    expect(content['books'].first['title']).to eq('Dead Until Dark')
    expect(content['books'].first['author']).to eq('Charlaine Harris')
  end

  it('returns a single book') do
    book_1 = Book.create(title: 'Club Dead', author: 'Charlaine Harris')
    book_2 = Book.create(title: 'Dead as a Doornail', author: 'Charlaine Harris')

    get "/api/v1/#{book_2.id}"



  end
end