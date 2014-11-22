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
    erb :"sessions/new"
  end

  post '/users/forgot_password' do
    user = User.first(:email => params[:email])
    if user
      token = (1..64).map{('A'..'Z').to_a.sample}.join
      timestamp = Time.now
      user.update(password_token: token, password_token_timestamp: timestamp)
      flash[:notice] = "Instructions to reset password being sent to #{params[:email]}"
      redirect to('/users/reset_password/:token')
    else
      flash[:notice] = "Sorry, invalid user email"
      redirect to('/sessions/new')
    end
  end

end