# File: Rakefile
# Usage: rake

require 'fileutils'
OUTPUTDIR='output'

desc 'Default: help'
task :default => :help do
end

desc 'Delete output files'
task :clean do
  FileUtils.rm_r OUTPUTDIR
  FileUtils.mkdir OUTPUTDIR
  system("echo '*.*' > #{OUTPUTDIR}/.gitignore")
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
