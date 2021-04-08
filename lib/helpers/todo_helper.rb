# frozen_string_literal: true

# This module provides helper methods to display the
# information of the TodoList instance to the user.
module TodoHelper
  def display_all_todos(undone:, done:)
    if undone.any? || done.any?
      _display_todos(undone)
      _display_done_todos(done)
      _display_todos_count_message(undone)
    else
      _display_no_matches
    end
  end

  def display_undone_todos(todos_list)
    if todos_list.any?
      _display_todos(todos_list)
      _display_todos_count_message(todos_list)
    else
      _display_no_matches
    end
  end

  def _display_done_todos(todos_list)
    todos_list.each do |todo|
      puts "*  ~~#{todo.description}~~"
    end
  end

  def _display_todos(todos_list)
    puts 'ID Description'
    puts '-- -----------'
    todos_list.each_with_index do |todo, idx|
      puts "#{_two_characters_format(idx + 1)} #{todo.description}"
    end
  end

  def _display_todos_count_message(todos_list)
    todos_count = todos_list.length
    if todos_count > 1
      puts "\n#{todos_count} tasks."
    else
      puts "\n#{todos_count} task."
    end
  end

  def _two_characters_format(number)
    return number.to_s if number > 9

    "#{number} "
  end

  def _display_no_matches
    puts 'No matches'
  end
end
