require './app'

class LibraryApp
  def initialize
    @app = App.new
    run
  end

  def show_menu
    puts 'Please choose an option by entering a number:'
    puts '1 - List all books'
    puts '2 - List all people'
    puts '3 - Create a person'
    puts '4 - Create a book'
    puts '5 - Create a rental'
    puts '6 - List all rentals for a given person id'
    puts '7 - Exit'
  end

  def user_option
    gets.chomp
  end

  def choose_option(option)
    case option
    when '1'
      @app.list_books
    when '2'
      @app.list_people
    when '3'
      @app.create_person
    when '4'
      @app.create_book
    when '5'
      @app.create_rental
    when '6'
      @app.list_rentals
    when '7'
      puts 'Exiting...'
      return false
    else
      puts 'Invalid value!'
    end
    true
  end

  def run
    puts 'Welcome to the school library App!'
    running = true

    while running
      show_menu
      selected_option = user_option
      running = choose_option(selected_option)
    end
  end
end

LibraryApp.new
