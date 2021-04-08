require 'test_helper'

describe Todo do
  let(:description) { 'something to do' }
  let(:todo) { Todo.new(description: description) }

  describe '#initialize' do
    describe 'when a description is given' do
      it 'creates a valid instance' do
        _(todo.description).must_equal description
      end
    end
  end

  describe '#update' do
    describe 'when there are no arguments given' do
      it 'there are no changes over the current instance' do
        todo.update
        _(todo.description).must_equal description
      end
    end

    describe 'when one argument is given' do
      describe 'when the given argument does not exist as an attribute' do
        it 'it sets the given keyword argument as an attribute of the todo' do
          todo.update(extended_description: 'long description')
          _(todo.instance_variable_get('@extended_description')).must_equal('long description')
        end
      end

      describe 'when the given argument already exist as an attribute' do
        it "overrides the attribute's value with the new value" do
          todo.update(description: 'something new to do')
          _(todo.description).must_equal('something new to do')
        end
      end
    end
  end
end
