=begin
Basic library program in ruby. 

Phil Wilt phillip.wilt@gmail.com

=end


=begin
	Book class for a library.

	name - name of the book
	shelf - the shelf to add the book to


=end
class Book 
	attr_accessor :name
	def initialize(name, shelf = nil)
		@name = name
		 enshelf(shelf) if shelf != nil 
	end

	def enshelf(shelf)
		@shelf = shelf
		@shelf.add_book(self)
	end

	def unshelf
		@shelf.remove_book(self)
		@shelf = nil
	end
end

=begin
	Shelf class to hold books. 

	Constructor:
		books - an array of books

	Note: If add_book or remove_book is called other than from a book object
			it will leave the book in an invalid state.
=end
class Shelf
	attr_reader :num_books
	def initialize(books = nil) 
		if books 
			@books = books
		else
			@books = []
		end
		@num_books = @books.count
	end

	def add_book(book)
		if @books.include?(book)
			puts "This book is already on the shelf!"
		else
			@books.push(book)
			@num_books = @books.count
			@books
		end
	end

	def remove_book(book)
		if @books.include?(book)
			@books.delete(book) 
		else
			puts "This book is not on this self!"
		end
	end

	def list_books()
		book_list = []
		@books.each {|book| book_list.push(book.name)}
		book_list * ", "
	end
end

=begin
	
	Library class that holds shelves of books

	Constructor - 
		shelves  - an array of shelves
=end
class Library
	attr_reader :num_shelves

	def initialize(shelves = nil)
		if shelves
			@shelves = shelves 
		else
			@shelves = Array.new()
		end
		@num_shelves = @shelves.count
	end

	def add_shelf(shelf)
		@shelves.push(shelf)
		@num_shelves = @shelves.count
	end

	def list_books
		book_list = []
		@shelves.each {|shelf| book_list.push(shelf.list_books)}
		book_list * ", "
	end

	def num_books
		n = 0
		@shelves.each {|shelf| n += shelf.num_books}
		n
	end
end

#Begin Main Method

#Create our objects
library = Library.new()
shelf = Shelf.new()
book = Book.new("War and Peace")

puts "Put first book on shelf, duplicate and list"
book.enshelf(shelf)
puts shelf.list_books
book.enshelf(shelf)
puts shelf.list_books

puts "Put second book on shelf, remove then put back"

book2 = Book.new("Jobs")
book2.enshelf(shelf)
puts shelf.list_books
book2.unshelf()
puts shelf.list_books
book2.enshelf(shelf)

puts "Add some more books"
Book.new("Catcher in the Rye").enshelf(shelf)
Book.new("Jobs").enshelf(shelf)
puts shelf.list_books

puts "Create a second shelf"
shelf2 = Shelf.new()
Book.new("Taco Bell: Behind the Cheese").enshelf(shelf2)
Book.new("Fear and Loathing").enshelf(shelf2)
Book.new("Little House on the Scary", shelf2)
puts shelf2.list_books

library.add_shelf(shelf)
puts "Books in the library: " + library.list_books
puts "Number of shelves: " + String(library.num_shelves)

library.add_shelf(shelf2)
puts "Books in the library: " + library.list_books
puts "Number of shelves: " + String(library.num_shelves)
puts "Number of books: " + String(library.num_books)

#End Main Method

