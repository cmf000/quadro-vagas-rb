require 'rails_helper'

describe 'admin registers job type', type: :system do
  xit 'access button' do
  end

  it 'with status active' do
    admin = FactoryBot.create(:user, role: :admin)

    login_as admin
    visit new_job_type_path
    fill_in 'Nome',	with: 'Estágio'
    check 'Ativo'
    click_on 'Salvar'

    expect(current_path).to eq job_types_path
    expect(page).to have_content 'Tipo de vaga criada com sucesso'
    expect(page).to have_content 'Estágio'
    expect(JobType.last.active).to eq true
  end

  it 'with status archived' do
    admin = FactoryBot.create(:user, role: :admin)

    login_as admin
    visit new_job_type_path
    fill_in 'Nome',	with: 'Estágio'
    click_on 'Salvar'

    expect(current_path).to eq job_types_path
    expect(page).to have_content 'Tipo de vaga criada com sucesso'
    expect(page).to have_content 'Estágio'
    expect(JobType.last.active).to eq false
  end

  it 'only admin users are allowed to create a job type' do
    regular = FactoryBot.create(:user, role: :regular)

    login_as regular

    visit new_job_type_path

    expect(current_path).to eq root_path
    expect(page).to have_content 'Acesso não autorizado'
  end

  it 'user must be authenticated' do
    visit new_job_type_path

    expect(current_path).to eq new_session_path
  end

  xit 'name is required' do
    admin = FactoryBot.create(:user, role: :admin)

    login_as admin
    visit new_job_type_path
    fill_in 'Nome',	with: ''
    click_on 'Salvar'

    expect(page).to have_content 'Não foi possível criar o tipo de vaga'
    expect(page).to have_content 'Nome é obrigatório'
  end
end
