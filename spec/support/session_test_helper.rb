module LoginTestHelper
  def login_as(user)
    visit new_session_path
    fill_in 'email_address', with: user.email_address
    fill_in 'password', with: user.password
    click_button 'commit' # Botão de Entrar
  end
end
