# frozen_string_literal: true

# Plays the role of intermediary between the Main class and the Todo class
class TodosController
  def add(description:)
    todo = Todo.new(description: description)
    todo_list.add(todo)
    todo_list.undone_count
  end

  def list
    {
      done_items: todo_list.done,
      undone_items: todo_list.undone
    }
  end

  def done(idx)
    todo_list.move_to_done(idx)
  end

  def delete(idx)
    todo_list.delete(idx)
  end

  def find(idx)
    todo_list.find(idx)
  end

  private

  def todo_list
    TodoList.instance
  end
end
