class BookmarkManager < Sinatra::Base 

  get '/users/new' do
    @user = User.new
    erb :"users/new"
  end

  post '/users' do
    @user = User.create(:email => params[:email],
                        :password => params[:password],
                        :password_confirmation => params[:password_confirmation])
    if @user.save
      session[:user_id] = @user.id
      redirect to('/')
    else
      flash.now[:errors] = @user.errors.full_messages
      erb :"users/new"
    end
  end

  get '/users/reset_password/:token' do
    user = User.first(:password_token => params[:token])
    if Time.now - user.password_token_timestamp < 86400 # day in seconds
      erb :"users/new_password"
    else
      flash[:notice] = "Sorry, your link to reset password is expired"
      redirect to('/sessions/new')
    end
  end

  post '/users/forgot_password' do
    user = User.first(:email => params[:email])
    if user
      user.update(password_token: token, password_token_timestamp: timestamp)
      send_simple_message
      flash[:notice] = "Instructions to reset password being sent to #{params[:email]}"
      redirect to('/')
    else
      flash[:notice] = "Sorry, invalid user email"
      redirect to('/sessions/new')
    end
  end

end