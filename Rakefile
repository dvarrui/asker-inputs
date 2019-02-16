# File: Rakefile
# Usage: rake

require 'fileutils'
OUTPUTDIR='output'
VERSION='19.02.2'

desc 'Default: help'
task :default => :help do
end

desc 'Delete output files'
task :clean do
  FileUtils.rm_r OUTPUTDIR
end

desc 'Show help'
task :help do
  system('rake -T')
end

desc 'Update project'
task :update do
  puts "[INFO] Pulling <asker-inputs> repo..."
  system('git pull')
end

desc 'Show version'
task :version do
  puts "version #{VERSION} (asker-inputs)"
end
