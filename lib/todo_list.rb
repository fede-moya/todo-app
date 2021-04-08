# frozen_string_literal: true

require 'singleton'
require 'singleton_storer'

# Singleton class resposible for managing the CRUD operations related
# to a Todo instance.
class TodoList
  PERSISTED_ATTRIBUTES = %i[undone_todos done_todos].freeze

  include Singleton
  include SingletonStorer

  def initialize
    set_defaults
  end

  def add(todo)
    @undone_todos << todo
  end

  def move_to_done(idx)
    raise TodoNotFoundError unless in_range?(idx)

    @done_todos << remove_from_undone(idx)
  end

  def done
    @done_todos
  end

  def undone
    @undone_todos
  end

  def undone_count
    @undone_todos.length
  end

  def find(idx)
    raise TodoNotFoundError unless in_range?(idx)

    @undone_todos[idx]
  end

  def delete(idx)
    remove_from_undone idx
  end

  private

  attr_accessor(*PERSISTED_ATTRIBUTES)

  def set_defaults
    @undone_todos = []
    @done_todos = []
  end

  def remove_from_undone(idx)
    raise TodoNotFoundError unless in_range?(idx)

    @undone_todos.delete_at(idx)
  end

  def in_range?(idx)
    (0..(@undone_todos.length - 1)).include?(idx)
  end
end
