class BookmarkManager < Sinatra::Base

  get '/sessions/new' do
    erb :"sessions/new"
  end

  post '/sessions' do
    email, password = params[:email], params[:password]
    user = User.authenticate(email, password)
    if user
      session[:user_id] = user.id
      redirect to('/')
    else
      flash[:errors] = ["The email or password is incorrect"]
      erb :"sessions/new"
    end
  end

  post '/sessions/forgot' do
    erb :forgotten_password
  end

  post '/sessions/new' do
    flash[:notice] = "Instructions to reset password being sent to #{params[:email]}"
    erb :"sessions/new"
  end

  delete '/sessions' do
    flash[:notice] = "Good bye!"
    session[:user_id] = nil
    redirect to('/')
  end 

end


