def current_user
  @current_user ||= User.get(session[:user_id]) if session[:user_id]
end

def token
  @token = (1..64).map{('A'..'Z').to_a.sample}.join
end

def timestamp
  @timestamp = Time.now
end

def send_simple_message
  RestClient.post "https://api:key-511213ccddec0d0011222357a21c3558"\
  "@api.mailgun.net/v2/sandboxade8e1953e7f44919e21034bcd53a3b4.mailgun.org/messages",
  :from => "Mailgun Sandbox <postmaster@sandboxade8e1953e7f44919e21034bcd53a3b4.mailgun.org>",
  :to => "Pavel <pavel.redics@gmail.com>",
  :subject => "Hello Pavel",
  :text => "Here is your link to change your password http://localhost:9292/users/reset_password/:#{token}"
end


