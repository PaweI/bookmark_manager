def current_user
  @current_user ||= User.get(session[:user_id]) if session[:user_id]
end

def token
  @token = (1..64).map { ('A'..'Z').to_a.sample }.join
end

def timestamp
  @timestamp = Time.now
end

def send_simple_message
  RestClient.post "https://#{ENV['MAILGUN_API_KEY']}"\
  "@api.mailgun.net/v2/#{ENV['MAILGUN_FROM_ADDRESS']}/messages",
                  from: "Mailgun Sandbox <#{ENV['MAILGUN_FROM_ADDRESS']}>",
                  to: 'Pavel ***',
                  subject: 'Hello Pavel',
                  text: "Here is your link to change your password http://localhost:9292/users/reset_password/:#{token}"
end
