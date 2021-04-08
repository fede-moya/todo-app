# frozen_string_literal: true

# This module provides helper methods to display
# informative messages to the user
module MainHelper
  def display_description_needed_message
    puts 'You must provide a description for the task'
  end

  def display_something_went_wrong_message(msg)
    puts "Sorry, something went wrong: #{msg}"
  end

  def display_created_task_message(idx)
    puts "Created task #{idx}"
  end

  def confirm_deletion_message(idx, todo)
    "Permanently delete task #{idx + 1} #{todo.description}?  (yes/no)"
  end

  def print_successfull_deletion_message
    puts 'To-Do successfully deleted'
  end
end
