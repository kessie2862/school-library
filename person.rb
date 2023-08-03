require './trimmer_decorator'
require './capitalize_decorator'
require './nameable'

class Person < Nameable
  @id_counter = 0

  attr_accessor :id, :name, :age, :rentals

  def initialize(name = 'Unknown', age = 0, parent_permission: true)
    super()
    @id = generate_id
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

  def generate_id
    self.class.instance_variable_get(:@id_counter) || self.class.instance_variable_set(:@id_counter, 0)
    self.class.instance_variable_set(:@id_counter, self.class.instance_variable_get(:@id_counter) + 1)
  end
end
