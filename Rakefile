require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:all) do |t|
  t.name = 'test'
  t.pattern = 'test/**/*_test.rb'
end

task default: ["test"]
