require_relative 'nameable'

class Person < Nameable
  attr_accessor :name, :age
  attr_reader :id

  def initialize(name = 'Unknown', age = nil, parent_permission: true)
    super()
    @id = Time.now.strftime('%Y%d%m%H%M%S%Z').to_i
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  def correct_name
    @name
  end

  def add_rental(date, book)
    Rental.new(date, book, self)
  end

  private

  def of_age?
    @age.to_i >= 18
  end
end
