require "bundler/gem_tasks"
require "rubygems"  
require "rake"  
require "rake/testtask"  
task :default => [:test]  
Rake::TestTask.new do |test|  
  test.libs << "test"  
  test.test_files = Dir[ "test/*.rb" ]  
  test.verbose = true  
end
#task :default => :welcome
 #task :welcome do
  #  puts "Hi This is JPush api ruby client"
  #end
