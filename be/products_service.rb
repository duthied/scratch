# products_service.rb
# Encoding: utf-8
require 'rubygems'  
require 'bundler'
require 'ostruct'

Bundler.require

require 'sinatra'
require 'roar/decorator'
require 'roar/json'
require 'roar/json/hal'
 
require 'rack/conneg'

configure do  
  set :server, :puma # default to puma for performance
end  

get '/products/?' do  
  
  product = OpenStruct.new
	product.name = "Product Main"
	product.id = 3
	
	ProductRepresenter.new(product).to_json
end

class ProductRepresenter < Roar::Decorator
	include Roar::JSON::HAL

  property :name
  property :id

  link :self do
    "/products/#{represented.id}"
    # "/products"
  end
end  