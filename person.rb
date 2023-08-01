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
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  def correct_name
    @name
  end

  private

  def of_age?
    @age.to_i >= 18
  end
end
