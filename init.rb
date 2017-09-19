require "sequel"

puts "INIT"
# connect to an in-memory database
#DB = Sequel.connect('sqlite://blog.db', loggers: [Logger.new($stdout)])
DB = Sequel.connect('sqlite://blog.db')