require 'json'
require_relative 'session'

session = Session.new(data_file: 'current_session')

puts session.greeting

puts "What do you want to look up?"
fetch_type = gets.chomp

session.fetch(fetch_type) 



# formatted = JSON.pretty_generate(fetched)
# puts "#{fetched[0]["rank"]}. #{fetched[0]["team"]["name"]}"
# puts session.farewell