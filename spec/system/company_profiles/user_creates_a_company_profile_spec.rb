require 'rails_helper'

describe 'Registered user tries to access the page to create a company profile', type: :system do
  it 'but first, has to be signed in' do
    create(:user)
    visit root_path

    expect(page).not_to have_link 'Perfil da Empresa'
  end

  it 'and succeeds', js: true do
    user = create(:user)
    visit root_path

    click_on 'Entrar'
    fill_in 'Enter your email address', with: user.email_address
    fill_in 'Enter your password', with: user.password
    within '#login_form' do
      click_on 'Sign in'
    end
    click_on 'Perfil da Empresa'
    fill_in 'Nome', with: 'BlinkedOn'
    fill_in 'URL do Site', with: 'https://blinkedon.tech'
    fill_in 'Email de Contato', with: 'contact@blinkedon.tech'
    attach_file 'Logo', Rails.root.join('spec', 'support', 'files', 'logo.png')
    click_on 'Criar Perfil de Empresa'

    expect(page).to have_content 'Perfil de Empresa criado com sucesso!'
    expect(page).to have_content 'Perfil da minha Empresa'
    expect(page).to have_content "Nome: BlinkedOn"
    expect(page).to have_content "Email de Contato: contact@blinkedon.tech"
    expect(page).to have_content "URL do Site: https://blinkedon.tech"
    expect(page).to have_css('img[src*="logo.png"]')
  end

  it 'and fails when informing invalid data', js: true do
    user = create(:user)
    visit root_path

    click_on 'Entrar'
    fill_in 'Enter your email address', with: user.email_address
    fill_in 'Enter your password', with: user.password
    within '#login_form' do
      click_on 'Sign in'
    end
    click_on 'Perfil da Empresa'
    fill_in 'Nome', with: ''
    fill_in 'URL do Site', with: 'https://blinkedon.tech'
    fill_in 'Email de Contato', with: 'contact@blinkedon.tech'
    attach_file 'Logo', Rails.root.join('spec', 'support', 'files', 'logo.png')
    click_on 'Criar Perfil de Empresa'

    expect(current_path).to eq new_company_profile_path
    expect(page).to have_content 'Erro ao tentar criar Perfil de Empresa'
    expect(page).to have_content 'Nome não pode ficar em branco'
  end
end
