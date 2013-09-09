get '/' do
  erb :index
end

post '/create' do
	user = User.create(params["user"])
	session[:user_id] = user.id
	redirect to '/secret'
end

get '/secret' do
	if logged_in?
	  erb :secret
	else
		redirect to '/'
	end
end

get '/logout' do
	session.clear
	redirect to '/'
end

post '/login' do
	p params
	user = User.authenticate(params["user"])
	session[:user_id] = user.id
	redirect to '/secret'
end


