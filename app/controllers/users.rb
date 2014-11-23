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
      user.update(password_token: token, password_token_timestamp: timestamp)
      flash[:notice] = "Instructions to reset password being sent to #{params[:email]}"
      redirect to('/')
    else
      flash[:notice] = "Sorry, invalid user email"
      redirect to('/sessions/new')
    end
  end

  def send_simple_message
  RestClient.post "https://api:key-511213ccddec0d0011222357a21c3558"\
  "@api.mailgun.net/v2/sandboxade8e1953e7f44919e21034bcd53a3b4.mailgun.org/messages",
  :from => "Mailgun Sandbox <postmaster@sandboxade8e1953e7f44919e21034bcd53a3b4.mailgun.org>",
  :to => "Pavel <pavel.redics@gmail.com>",
  :subject => "Hello Pavel",
  :text => "Congratulations Pavel, you just sent an email with Mailgun!  You are truly awesome!  You can see a record of this email in your logs: https://mailgun.com/cp/log .  You can send up to 300 emails/day from this sandbox server.  Next, you should add your own domain so you can send 10,000 emails/month for free."
end

end