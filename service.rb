require 'sinatra'
require './sequel-demo.rb'
require 'multi_json'


get '/books' do
  content_type :json
  MultiJson.dump(Book.all.map { |s| s.to_api })
end
