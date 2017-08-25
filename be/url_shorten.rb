# url_shorten.rb
# Encoding: utf-8
require 'rubygems'  
require 'bundler'
require 'ostruct'

Bundler.require

require 'sinatra'
require 'redis'
require 'rack/conneg'

require 'byebug'

redis = Redis.new(host: ENV['REDIS_PORT_6379_TCP_ADDR'], port: ENV['REDIS_PORT_6379_TCP_PORT'])

configure do  
  set :server, :puma # default to puma for performance
end  

helpers do
	include Rack::Utils
	alias_method :h, :escape_html

	def random_string(length)
		rand(36**length).to_s(36)
	end
end

get '/' do
	@host_with_port = request.host_with_port
	erb :index
end

post '/shortcode' do
	@host_with_port = request.host_with_port
	if params[:url] and not params[:url].empty?
		@shortcode = random_string 5
		redis.setnx "links:#{@shortcode}", params[:url]
	end
	erb :shortcode
end

post '/lookup' do
	@url = redis.get "links:#{params[:url]}"
	erb :lookup
end

get '/shortcode/:shortcode' do
	@host_with_port = request.host_with_port
	@url = redis.get "links:#{params[:shortcode]}"
	redirect @url || '/'
end
