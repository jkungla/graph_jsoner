require 'sinatra'
require 'json'
require 'pg'
require 'sinatra/activerecord'
# Require models
Dir["#{Dir.pwd}/models/*.rb"].each { |file| require file }

####### CONFIG #######
set :port, 8080
######################

before do
  ## JQuery ei luba muidu datat lugeda
  headers 'Access-Control-Allow-Origin' => '*'
end

error do
  {}.to_json
end

get '/laekumised.json' do
  content_type :json
  json = {}
  User.all.each do |u|
    puts u.laekumiste_summa
    json[u.callsign] = u.laekumiste_summa
  end
  json.to_json
end

get '/users.json' do
  content_type :json
  json = {}
  User.all.each do |u|
    json[u.id] = u.name
  end
  json.to_json
end

get '/nouded/:tegeleja' do
  content_type :json
  json = {}
  user = User.find(params[:tegeleja])
  user.claims.each do |u|
    json[u.id] = u.viitenumber
  end
  json.to_json
end


get '/users/:callsign' do
  content_type :json
  @user = User.where(:callsign => params[:callsign])
  @user.to_json
end

post '/users' do
  if params[:user]
    @user = User.create(params[:user])
  end
end

post '/claims' do
  if params[:claim]
    @claim = Claim.create(params[:claim])
  end
end

post '/payments' do
  p params
  if params[:payment]
    @payment = Payment.create(params[:payment])
  end
end

#test
post '/laekumine' do
  puts "Hello!"
  puts params
end