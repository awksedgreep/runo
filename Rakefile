# frozen_string_literal: true

desc 'Remove logs'
task :rm_logs do
  puts 'Removing logs'
  files = Dir['*.log*']
  rm(files, verbose: true) unless files.empty?
end

desc 'Make rdocs'
task :rdocs => :rm_logs do
  puts 'Making rdocs'
  sh 'rdoc'
end

desc 'Run tests'
task :test do
  puts 'Running rspec tests . . . '
  sh 'bin/rspec'
end
