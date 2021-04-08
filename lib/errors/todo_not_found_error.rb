# frozen_string_literal: true

# Error to be raised when there is no registry of a todo with certain ID.
class TodoNotFoundError < StandardError
  def message
    'Sorry, there is no Todo item with such ID'
  end
end
