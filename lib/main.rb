# frozen_string_literal: true

require 'thor'
require_relative 'helpers/todo_helper'
require_relative 'helpers/main_helper'

# It's responsible for the application initialization and
# for the client communication interface.
class Main < Thor
  include TodoHelper
  include MainHelper

  desc 'add TASK DESCRIPTION', 'Add tasks to a todo list'
  def add(*description)
    return unless validate_description_presence(description)

    todo_idx = with_rescue do
      todos_controller.add(description: description.join(' '))
    end
    display_created_task_message(todo_idx)
  end

  desc 'done IDX', 'Mark the todo with the provided <<IDX>> as done'
  def done(idx)
    with_rescue do
      todos_controller.done(idx.to_i - 1)
    end
  end

  desc 'delete IDX', 'Delete the task with the given IDX'
  def delete(idx)
    with_rescue do
      index = idx.to_i - 1
      todo = todos_controller.find(index)
      if require_deletion_confirmation(index, todo)
        todos_controller.delete(index)
        print_successfull_deletion_message
      end
    end
  end

  desc 'list', 'Display a list of the tasks'
  option :all
  def list
    todos = with_rescue do
      todos_controller.list
    end

    if options['all']
      display_all_todos(undone: todos[:undone_items], done: todos[:done_items])
    else
      display_undone_todos(todos[:undone_items])
    end
  end

  class << self
    def exit_on_failure?
      true
    end
  end

  private

  def validate_description_presence(description)
    return true if description.count.positive?

    display_description_needed_message
    false
  end

  def todos_controller
    TodosController.new
  end

  def require_deletion_confirmation(idx, todo)
    confirm = nil
    until %w[y n].include?(confirm)
      confirm = ask(confirm_deletion_message(idx, todo))
    end

    confirm == 'y'
  end

  def with_rescue
    yield
  rescue TodoNotFoundError => e
    puts e.message.to_s
  rescue StandardError => e
    display_something_went_wrong_message(e.message)
  end
end
