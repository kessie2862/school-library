require_relative 'person'

class Teacher < Person
  attr_accessor :rentals

  def initialize(age, specialization, name = 'Unknown')
    super(name, age)
    @specialization = specialization
    @rentals = []
  end

  def can_use_services?
    true
  end
end
