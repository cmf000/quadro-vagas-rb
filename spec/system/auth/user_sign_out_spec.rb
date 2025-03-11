require 'rails_helper'

describe 'User registration', type: :system do
  it 'successfully' do
    visit new_registration_path

    fill_in 'Nome', with: 'João'
    fill_in 'Sobrenome', with: 'Silva'
    fill_in 'E-mail', with: 'joao@email.com'
    fill_in 'Senha', with: 'password123'
    fill_in 'Confirmação de Senha', with: 'password123'

    click_on 'Cadastrar'

    within 'header nav' do
      click_on 'Sair'
    end

    expect(page).not_to have_button 'Sair'
    expect(current_path).to eq new_session_path
  end
end
