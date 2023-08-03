require './app'

class SchoolLibraryApp
  OPTIONS = {
    '1' => :list_books,
    '2' => :list_people,
    '3' => :create_person,
    '4' => :create_book,
    '5' => :create_rental,
    '6' => :list_rentals,
    '7' => :exit
  }.freeze

  def initialize
    @app = App.new
    welcome_message
  end

  def welcome_message
    puts 'Welcome to the school library App!'
    run_options
  end

  def run_options
    loop do
      show_list
      user_option = gets.chomp

      if OPTIONS.key?(user_option)
        send(OPTIONS[user_option])
        break if user_option == '7'
      else
        puts 'Invalid value!'
      end
    end
  end

  def show_list
    puts 'Please choose an option by entering a number:'
    puts '1 - List all books'
    puts '2 - List all people'
    puts '3 - Create a person'
    puts '4 - Create a book'
    puts '5 - Create a rental'
    puts '6 - List all rentals for a given person id'
    puts '7 - Exit'
  end

  def list_books
    @app.list_books
  end

  def list_people
    @app.list_people
  end

  def create_person
    @app.create_person
  end

  def create_book
    @app.create_book
  end

  def create_rental
    @app.create_rental
  end

  def list_rentals
    @app.list_rentals
  end

  def exit
    puts 'Goodbye!'
  end
end

SchoolLibraryApp.new
