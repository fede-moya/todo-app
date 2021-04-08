require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs = %w(test lib)
  t.test_files = FileList['test/**/*_spec.rb']
end

task :linter do
  sh 'bundle exec rubocop lib'
end
