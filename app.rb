require_relative 'capitalize_decorator'
require_relative 'classroom'
require_relative 'nameable'
require_relative 'decorator'
require_relative 'trimmer_decorator'
require_relative 'rental'
require_relative 'person'
require_relative 'teacher'
require_relative 'student'
require_relative 'book'

class App
  def initialize
    @books = []
    @people = {}
  end

  def list_books
    puts 'No books available' if @books.empty?
    puts
    @books.each do |book|
      puts "Title: #{book.title}, Author: #{book.author}"
      puts
    end
  end

  def list_people
    puts 'No one has registered' if @people.empty?
    puts
    @people.values.each do |person|
      puts "[#{person.class}] ID: #{person.id}, Name: #{person.name}, Age: #{person.age}"
      puts
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
      puts 'Option invalid, please try again'
      puts
    end
  end

  def create_student
    puts
    print 'Name: '
    name = gets.chomp
    print 'Age: '
    age = gets.chomp.to_i
    print 'Has parent permission? [Y/N]: '
    has_parent_permission = gets.chomp.upcase

    parent_permission = case has_parent_permission
                        when 'Y' then true
                        when 'N' then false
                        else
                          puts 'Option invalid, please try again'
                          return
                        end

    student = Student.new(age, nil, name, parent_permission: parent_permission)
    @people[student.id] = student
    puts 'Student created successfully.'
    puts
  end

  def create_teacher
    puts
    print 'Name: '
    name = gets.chomp
    print 'Age: '
    age = gets.chomp.to_i
    print 'Specialization: '
    specialization = gets.chomp

    teacher = Teacher.new(age, specialization, name)
    @people[teacher.id] = teacher
    puts 'Teacher created successfully.'
    puts
  end

  def create_book
    puts
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp

    @books << Book.new(title, author)
    puts
    puts 'Book created successfully.'
    puts
  end

  def create_rental
    puts 'Select a book from the following list by number'
    @books.each_with_index do |book, index|
      puts "#{index}) Title: #{book.title}, Author: #{book.author}"
    end

    book_index = gets.chomp.to_i

    puts 'Select a person from the following list by number/index (not id)'
    puts
    @people.values.each_with_index do |person, index|
      puts "#{index}) [#{person.class}] ID: #{person.id}, Name: #{person.name}, Age: #{person.age}"
    end

    person_index = gets.chomp.to_i

    print 'Date: '
    rental_date = gets.chomp

    if valid_indices?(person_index, book_index)
      Rental.new(rental_date, @books[book_index], @people.values[person_index])
      puts 'Rental created successfully'
    else
      puts 'Invalid person or book selected.'
    end
  end

  def list_rentals
    puts
    print 'ID of person: '
    person_id = gets.chomp.to_i

    person_obj = @people.values.find { |person| person.id == person_id }

    if person_obj.nil?
      puts 'Person not found'
      return
    end

    puts 'Rentals:'
    person_obj.rentals.each do |rental|
      puts "Date: #{rental.date}, Book: #{rental.book.title} by #{rental.book.author}"
    end
    puts
  end

  private

  def valid_indices?(person_index, book_index)
    person_index >= 0 && person_index < @people.length && book_index >= 0 && book_index < @books.length
  end
end
