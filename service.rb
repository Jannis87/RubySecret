require 'sinatra'
require './sequel-demo.rb'
require './init.rb'
require './model.rb'



get '/books' do
  content_type :json
  MultiJson.dump(Book.all.map { |s| s.to_api })
end
