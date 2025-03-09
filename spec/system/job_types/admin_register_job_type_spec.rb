require 'rails_helper'

describe 'admin register job type', type: :system do
  it 'with success' do
    admin = FactoryBot.create(:user, role: :admin)

    login_as admin
    visit new_job_type_path
    fill_in 'Nome',	with: 'Estágio'
    check 'Ativo'
    click_on 'Salvar'

    expect(current_path).to eq job_types_path
    expect(page).to have_content 'Tipo de vaga criada com sucesso'
    expect(page).to have_content 'Estágio'
  end

  it 'only admin users are allowed to create a job type' do
    regular = FactoryBot.create(:user, role: :regular)

    login_as regular

    visit new_job_type_path

    expect(current_path).to eq root_path
    expect(page).to have_content 'Acesso não autorizado'
  end
end
