names = ['obi-wan', 'yoda', 'darth Vader']

names.each do |name|
  if i.start_with?('darth')
    puts "Bye " + name.upper
  else
    puts "Hello " + name.capitalize
  end
end
