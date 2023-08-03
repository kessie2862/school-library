require './capitalize_decorator'
require './classroom'
require './nameable'
require './decorator'
require './timmer_decorator'
require './rental'
require './person'
require './teacher'
require './student'
require './book'

class App
  def initialize(display_books = [], display_people = [])
    @display_books = display_books
    @display_people = display_people
  end

  def list_books
    if @display_books.empty?
      puts 'No books available'
    else
      puts
      @display_books.each do |book|
        puts "Title: #{book.title}, Author: #{book.author}"
        puts
      end
    end
  end

  def list_people
    if @display_people.empty?
      puts 'No one has registered'
    else
      puts
      @display_people.each do |person|
        puts "[#{person.class}] ID: #{person.id}, Name: #{person.name}, Age: #{person.age}"
        puts
      end
    end
  end

  def create_person
    puts
    print 'Do you want to create a student (1) or a teacher (2)? (Input the number): '
    puts
    person_type = gets.chomp
    case person_type
    when '1'
      create_student
    when '2'
      create_teacher
    else
      puts
      print 'Option invalid, please try again'
      puts
    end
  end

  def create_student
    puts
    print 'Name: '
    student_name = gets.chomp
    print 'Age: '
    student_age = gets.chomp.to_i
    print 'Has parent permission? [Y/N]: '
    has_parent_permission = gets.chomp.upcase
    parent_permission = has_parent_permission == 'Y'
    @display_people << Student.new(student_age, nil, student_name, parent_permission: parent_permission)
    puts
    puts 'Student created successfully.'
    puts
  end

  def create_teacher
    puts
    print 'Name: '
    teacher_name = gets.chomp
    print 'Age: '
    teacher_age = gets.chomp.to_i
    print 'Specialization: '
    teacher_specialization = gets.chomp
    @display_people << Teacher.new(teacher_age, teacher_specialization, teacher_name)
    puts
    puts 'Teacher created successfully.'
    puts
  end

  def create_book
    puts
    print 'Title: '
    book_title = gets.chomp
    print 'Author: '
    book_author = gets.chomp
    @display_books << Book.new(book_title, book_author)
    puts
    puts 'Book created successfully.'
    puts
  end

  def create_rental
    puts 'Select a book from the following list by number'
    @display_books.each_with_index do |book, index|
      puts "#{index}) Title: #{book.title}, Author: #{book.author}"
    end

    book_index = gets.chomp.to_i
    puts 'Select a person from the following list by number/index (not id)'
    puts
    @display_people.each_with_index do |person, index|
      puts "#{index}) [#{person.class}] ID: #{person.id}, Name: #{person.name}, Age: #{person.age}"
    end

    person_index = gets.chomp.to_i
    print 'Date: '
    rental_date = gets.chomp

    if valid_person_and_book?(person_index, book_index)
      Rental.new(rental_date, @display_people[person_index], @display_books[book_index])
      puts 'Rental created successfully'
    else
      puts 'Invalid person or book selected.'
    end
  end

  def list_rentals
    puts
    @display_people.each do |person|
      puts "- [#{person.class}] ID: #{person.id}, Name: #{person.name}, Age: #{person.age}"
    end

    print 'ID of person: '
    person_id = gets.chomp.to_i
    person_obj = @display_people.find { |person| person.id == person_id }

    if person_obj
      puts
      puts 'Rentals:'
      person_obj.rentals.each do |rental|
        puts "Date: #{rental.date}, Book: #{rental.book.title} by #{rental.book.author}"
      end
      puts
    else
      puts 'Person not found.'
    end
  end

  private

  def valid_person_and_book?(person_index, book_index)
    person_index.between?(0, @display_people.length - 1) && book_index.between?(0, @display_books.length - 1)
  end
end
