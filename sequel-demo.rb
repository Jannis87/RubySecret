require "rubygems"
require 'logger'
require './init.rb'
require './model.rb'

# create an items table
if DB.table_exists? :authors
    DB.drop_table :authors
end

if DB.table_exists? :books
    DB.drop_table :books
end

if DB.table_exists? :authors_books
    DB.drop_table :authors_books
end

unless DB.table_exists? :authors
    DB.create_table :authors do
    primary_key :id
    String :name
    end
end

unless DB.table_exists? :books
    DB.create_table :books do
    primary_key :id
    String :title
    end
end

unless DB.table_exists? :authors_books
    DB.create_table :authors_books do
    number :author_id
    number :book_id
    end
end

class Author < Sequel::Model
    String name
    many_to_many :books, class: :Book
end
  
class Book < Sequel::Model
    String @title
    many_to_many :authors, class: :Author

    def to_api
        {
          id: id,
          name: title,
          authors: authors.map{ |author| author.id }
        }
      end
end

  book = Book.create(title: "Just for Fun2")
  book2 = Book.create(title: "Just for Fun")
  author = Author.create(name: "Linus Tovalds")
  author2 = Author.create(name: "Linus Tovalds2")
  author3 = Author.create(name: "Linus Tovalds23")

  book.add_author(author)
  book.add_author(author2)
  book.add_author(author3)
  book2.add_author(author3)

  books = Book.all

  #puts books.first.authors

 books.each { |book|
    puts "#{book.id} #{book.title}"
    book.authors.each { |author|
        puts "   #{author.id} #{author.name}"
    }
 }
puts "\n"
 authors = Author.all
 authors.each { |author|
    puts "Author: #{author.name}"
    author.books.each {|book| 
        puts "   Book: #{book.title}"
    }
 }



 #books = DB[:books]
 #books.insert(book)

# create a dataset from the items table
#items = DB[:items]

# populate the table
#items.insert(:name => 'abc', :price => rand * 100)
#items.insert(:name => 'def', :price => rand * 100)
#items.insert(:name => 'ghi', :price => rand * 100)

# print out the number of records
#puts "Item count: #{books.count}"

# print out the average price
#puts "The average price is: #{items.avg(:price)}"