def login_as(user)
  visit new_session_path
  fill_in 'email_address', with: user.email_address
  fill_in 'password', with: user.password
  click_button 'commit' # Botão de Entrar
end

def request_login_as(user)
  post session_path params: { password: user.password, email_address: user.email_address }
end

# def login_as(user)
#   Current.session = user.sessions.create!
#   request = ActionDispatch::Request.new(Rails.application.env_config)
#   cookies = request.cookie_jar
#   cookies.signed[:session_id] = { value: Current.session.id, httponly: true, same_site: :lax }
# end
