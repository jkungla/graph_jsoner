require 'sinatra'
require 'json'
require 'pg'
require 'sinatra/activerecord'
# Require models
Dir["#{Dir.pwd}/models/*.rb"].each { |file| require file }

######################
get '/' do
  content_type :json
  @users = User.all
  p @users
  @claims = Claim.all
  @payment = Payment.all
  @claims.to_json
end

get '/users/:callsign' do
  content_type :json
  @user = User.where(:callsign => params[:callsign])
  @user.to_json
end

post '/users' do
  puts params
  if params[:user]
    @user = User.create(params[:user])
  end
end

post '/claims' do
  puts params
  @user = Claim.create(params[:claim])
end

post '/payments' do
  puts params
  @user = Payment.create(params[:payment])
end

#test
post '/laekumine' do
  puts "Hello!"
  puts params
end