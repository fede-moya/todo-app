# TodoCLI

A CLI program for managing to do tasks with the ability to sincronize with Trello.

## Installation

Install it yourself as:

    $ gem install todo-fede

## Usage

This is a CLI program so you need to open a terminal in order to run it. This CLI comes with two set of features. The first set is related to CRUD operations over todo items, and the second is a set of operations related to synchronizing the todos with [Trello](trello.com).

#### Crud operations
- To **add** a new todo type  `$ todo add An easy todo`
- To **list** all your todo items type `$ todo list`
- To mark a todo as **done** type `todo done` followed by the ID number of your todo item, e.g. `$ todo done 1`.
- To **delete** a todo type `todo delete` followed by the ID number of your todo item, e.g. `$ todo delete 1`.


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests and `rake linter` to run rubocop. You can also run `bin/console` for an interactive prompt that will allow you to experiment with the existent code (under the lib folder).

You can execute the program by running `bin/todo` at the root of the project, be aware that you need to give execution permissions to the file, you can use `chmod +x bin/todo` for that purposes.

Alternatively, you can install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/wyeworks/todo-fede.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
