require 'test_helper'

describe Main do
  let(:description) { 'something to do' }
  let(:main) { Main.new }
  let(:todo_list) { TodoList.instance }

  before do
    todo_list.send(:set_defaults)
  end

  describe '#add' do
    describe 'when a description is given' do
      it 'creates a new task with the given description' do
        std_out = capture_io do
          main.add description
        end

        todo_id = std_out.first.split(' ').last
        todo_id = todo_id.to_i
        _(todo_list.send(:undone_todos)[0].description).must_equal description
      end

      it 'prints a successfull creation message' do
        std_out = capture_io do
          main.add description
        end
        _(std_out.first).must_match(/Created task \d+/)
      end
    end

    describe 'when no description is given' do
      it 'prints a message requiring to provide a description' do
        std_out = capture_io do
          main.add
        end
        _(std_out.first).must_equal("You must provide a description for the task\n")
      end
    end
  end

  describe '#done' do
    describe 'when there is a todo item with the given index' do
      let(:todo) { Todo.new(description: 'An easy todo') }
      
      before do
        todo_list.send(:undone_todos=, [todo])
      end

      describe 'when the referenced todo is undone' do
        it 'changes the the status of the todo to done' do
          main.done 1
          _(todo_list.send(:done_todos)).must_equal [todo]
          _(todo_list.send(:undone_todos)).must_equal []
        end

        it 'prints no message' do
          std_out = capture_io do
            main.done 1
          end
          _(std_out.first).must_equal('')  
        end
      end
    end

    describe 'when there is no todo with the given index' do
      it 'prints no message' do
        std_out = capture_io do
          main.done 1
        end
        _(std_out.first).must_equal "Sorry, there is no Todo item with such ID\n"
      end
    end
  end

  describe '#delete' do
    describe 'when there is a task with the given index' do
      let(:todo) { Todo.new(description: 'An easy todo') }
      
      before do
        todo_list.send(:undone_todos=, [todo])
      end
      
      describe 'when confirmation is not provided' do
        it 'does not delete the associated todo' do
          Thor::LineEditor.stub :readline, 'n' do
            capture_io do
              main.delete 1
            end
          end
          
          _(todo_list.send(:undone_todos)).must_equal [todo]
        end
      end

      describe 'when confirmation is provided' do
        it 'deletes the associated todo' do
          Thor::LineEditor.stub :readline, 'y' do
            capture_io do
              main.delete 1
            end
          end
          
          _(todo_list.send(:undone_todos)).must_equal []
        end

        it 'prints a message informing about the deleted todo' do
          std_out = nil
          Thor::LineEditor.stub :readline, 'y' do
            std_out = capture_io do
              main.delete 1
            end
          end
          
          _(std_out.first).must_equal "To-Do successfully deleted\n"
        end
      end
    end

    describe 'when there is no task with the given index' do
      it 'prints no message' do
        std_out = capture_io do
          main.delete 1
        end
        _(std_out.first).must_equal "Sorry, there is no Todo item with such ID\n"
      end
    end
  end

  describe '#list' do
    describe 'when there are todos to display' do
      before do
        todo_list.send(:undone_todos=, [
          Todo.new(description: 'An easy todo'),
          Todo.new(description: 'A complex todo')
        ])

        todo_list.send(:done_todos=, [
          Todo.new(description: 'An easy done todo'), 
          Todo.new(description: 'A complex done todo')
        ])
      end

      it 'displays all undone todos' do
        std_out = capture_io do
          main.list
        end
        _(std_out.first).must_match(/ID Description\n-- -----------\n1  An easy todo\n2  A complex todo\n\n2 tasks./)
      end
    end

    describe 'when there are no todos to display' do
      it 'displays no matches messages' do
        std_out = capture_io do
          main.list
        end
        _(std_out.first).must_match(/No matches/)
      end
    end
  end

  describe '#list-all' do
    describe 'when there are todos to display' do
      before do
        todo_list.send(:undone_todos=, [
          Todo.new(description: 'An easy todo'),
          Todo.new(description: 'A complex todo')
        ])

        todo_list.send(:done_todos=, [
          Todo.new(description: 'An easy done todo'), 
          Todo.new(description: 'A complex done todo')
        ])
      end

      it 'displays all the todos' do
        std_out = capture_io do
          main.stub :options, { 'all' => true } do
            main.list
          end
        end
        _(std_out.first).must_equal("ID Description\n-- -----------\n1  An easy todo\n2  A complex todo\n*  ~~An easy done todo~~\n*  ~~A complex done todo~~\n\n2 tasks.\n")
      end
    end

    describe 'when there are no todos to display' do
      it 'displays no matches messages' do
        std_out = capture_io do
          main.stub :options, { 'all' => true } do
            main.list
          end
        end
        _(std_out.first).must_match(/No matches/)
      end
    end
  end
end
