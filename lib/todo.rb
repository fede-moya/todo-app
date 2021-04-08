# frozen_string_literal: true

# Representation of the main entity of the program, a to do item.
class Todo
  attr_accessor(:description)

  def initialize(description:)
    @description = description
  end

  def update(**attrs)
    attrs.each do |attr, value|
      instance_variable_set("@#{attr}".to_sym, value)
    end
  end
end
