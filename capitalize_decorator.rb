require_relative 'decorator'

class CapitalizeDecorator < Decorator
  def correct_name
    nameable_name = @nameable.respond_to?(:correct_name) ? @nameable.correct_name : @nameable
    nameable_name.to_s.capitalize
  end
end
