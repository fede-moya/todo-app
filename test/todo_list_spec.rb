require 'test_helper'

describe TodoList do
  let(:todo_description) { 'An easy todo' }
  let(:todo) { Todo.new(description: todo_description) }
  let(:todo_list) { TodoList.instance }

  before do
    todo_list.send(:set_defaults)
  end

  describe '#add' do
    it 'adds a todo to the todo list' do
      todo_list.add(todo)
      retrieved_todo = todo_list.send(:undone_todos)[0]
      _(retrieved_todo.description).must_equal(todo_description)
    end

    it 'the indexes grow sequentially' do
      todo_1 = Todo.new(description: 'a todo')
      todo_2 = Todo.new(description: 'another todo')
      todo_list.add(todo_1)
      todo_list.add(todo_2)
      
      _(todo_list.send(:undone_todos)[0]).must_equal(todo_1)
      _(todo_list.send(:undone_todos)[1]).must_equal(todo_2)
    end
  end


  describe '#done' do
    describe 'when there are todos in the list' do
      it 'returns an array that contains all of the done todos in the list ' do
        todo_1, todo_2 = Todo.new(description: 'A complex todo'), Todo.new(description: 'An easy todo')
        todo_3, todo_4 = Todo.new(description: 'A complex done todo'), Todo.new(description: 'An easy done todo')
        todo_list.send(:undone_todos=, [todo_1, todo_2])
        todo_list.send(:done_todos=, [todo_3, todo_4 ])

        _(todo_list.done).must_equal([todo_3, todo_4])
      end
    end
    
    describe 'when there are no undone todos in the list' do
      it 'returns an empty array' do
        todo_1, todo_2 = Todo.new(description: 'A complex todo'), Todo.new(description: 'An easy todo')
        todo_list.send(:undone_todos=, [todo_1, todo_2 ])
        todo_list.send(:done_todos=, [])

        _(todo_list.done).must_equal([])
      end
    end
  end

  describe '#undone' do
    describe 'when there are todos in the list' do
      it 'returns an array that contains all of the undone todos in the list ' do
        todo_1, todo_2 = Todo.new(description: 'A complex todo'), Todo.new(description: 'An easy todo')
        todo_3, todo_4 = Todo.new(description: 'A complex done todo'), Todo.new(description: 'An easy done todo')
        todo_list.send(:undone_todos=, [todo_1, todo_2])
        todo_list.send(:done_todos=, [todo_3, todo_4 ])

        _(todo_list.undone).must_equal([todo_1, todo_2])
      end
    end
    
    describe 'when there are no undone todos in the list' do
      it 'returns an empty array' do
        todo_1, todo_2 = Todo.new(description: 'A complex todo'), Todo.new(description: 'An easy todo')
        todo_list.send(:done_todos=, [todo_1, todo_2 ])
        todo_list.send(:undone_todos=, [])

        _(todo_list.undone).must_equal([])
      end
    end
  end

  describe '#move_to_done' do
    let(:todo_1) { Todo.new(description: 'An easy todo') }
    let(:todo_2) { Todo.new(description: 'A complex todo') }
    
    before do
      todo_list.send(:undone_todos=, [todo_1, todo_2])
    end

    describe 'when the given index is less than zero' do
      it 'raises TodoNotFoundError and the todos list does not change' do
        _(proc { todo_list.move_to_done(-1) }).must_raise TodoNotFoundError
        _(todo_list.send(:undone_todos)).must_equal [todo_1, todo_2]
      end
    end

    describe 'when the given index is greater than zero' do
      it 'removes the specified todo from the undone list' do
        todo_list.move_to_done(0)
        _(todo_list.send(:undone_todos)).must_equal [todo_2]
      end
  
      it 'add the specified todo to the list of done items' do
        todo_list.move_to_done(0)
        _(todo_list.send(:done_todos)).must_equal [todo_1]
      end
    end
  end

  describe '#undone_count' do
    it 'returns the amount of items in the done list' do
      todo_list.send(:undone_todos=, [
        Todo.new(description: 'An easy todo'),
        Todo.new(description: 'A complex todo')
      ])

      _(todo_list.undone_count).must_equal 2
    end
  end

  describe '#undone' do
    describe 'when there are todos in the list' do
      it 'returns an array that contains all of the undone todos in the list ' do
        todo_1, todo_2 = Todo.new(description: 'A complex todo'), Todo.new(description: 'An easy todo')
        todo_3, todo_4 = Todo.new(description: 'A complex done todo'), Todo.new(description: 'An easy done todo')
        todo_list.send(:undone_todos=, [todo_1, todo_2])
        todo_list.send(:done_todos=, [todo_3, todo_4 ])

        _(todo_list.undone).must_equal([todo_1, todo_2])
      end
    end

    describe 'when there are no undone todos in the list' do
      it 'returns an empty array' do
        todo_1, todo_2 = Todo.new(description: 'A complex todo'), Todo.new(description: 'An easy todo')
        todo_list.send(:done_todos=, [todo_1, todo_2 ])
        todo_list.send(:undone_todos=, [])

        _(todo_list.undone).must_equal([])
      end
    end
  end

  describe '#delete' do
    describe 'when there are todo items in the list' do
      let(:todo_1) { Todo.new(description: 'A complex todo') }
      let(:todo_2) { Todo.new(description: 'An easy todo') }

      before do
        todo_list.send(:undone_todos=, [todo_1, todo_2])
      end

      describe 'when the referenced todo is in the list' do
        it 'removes the referenced todo from the list' do
          todo_list.delete 0
          _(todo_list.send(:undone_todos)).must_equal [todo_2]
        end
      end

      describe 'when the referenced todo is not present in the list' do
        it 'does not change the todolist' do
          _(proc { todo_list.delete 3 }).must_raise TodoNotFoundError
        end
      end
    end

    describe 'when there are no items in the list' do
      it 'raises TodoNotFoundError' do
        _(proc { todo_list.delete 0 }).must_raise TodoNotFoundError
      end
    end
  end
end
