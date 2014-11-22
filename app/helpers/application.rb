def current_user
  @current_user ||= User.get(session[:user_id]) if session[:user_id]
end

def token
  @token = (1..64).map{('A'..'Z').to_a.sample}.join
end

def timestamp
  @timestamp = Time.now
end


