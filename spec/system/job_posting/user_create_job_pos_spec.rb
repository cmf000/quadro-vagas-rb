require 'rails_helper'

describe 'user create job post', type: :system do
  it 'but first, has to be signed in' do
    visit root_path

    expect(page).not_to have_link 'Anunciar vaga'
  end

  it 'sucessfully', js: true do
    user = create(:user)
    create(:company_profile, user: user)
    create(:job_type, name: 'Part time')
    ExperienceLevel.create!(name: 'Junior')

    login_as user

    visit root_path

    click_on 'Anunciar vaga'
    fill_in 'Título', with: 'Desenvolvedor backend'
    select 'Mensal', from: 'Período do salário'
    select 'BRL', from: 'Moeda'
    fill_in 'Salário', with: '1234'
    select 'Part time', from: 'Tipo de trabalho'
    select 'Remoto', from: 'Arranjo de trabalho'
    select 'Junior', from: 'Nível de experiência'
    find('trix-editor').click.set("teste")
    click_on 'Anunciar'

    expect(page).to have_content 'Anúncio criado com sucesso'
    expect(page).to have_content 'Desenvolvedor backend'
    expect(page).to have_content 'BlinkedOn'
    expect(page).to have_content 'Part time'
  end

  it 'fail due to empty required fields' do
    user = create(:user)
    create(:company_profile, user: user)
    create(:job_type, name: 'Part time')
    ExperienceLevel.create!(name: 'Junior')

    login_as user

    visit root_path

    click_on 'Anunciar vaga'
    fill_in 'Título', with: 'Desenvolvedor backend'
    click_on 'Anunciar'

    expect(page).to have_content 'Erro ao tentar criar Anúncio da vaga'
  end

  it 'and can only choose from active job types' do
    user = create(:user)
    create(:company_profile, user: user)
    create(:job_type, name: 'Part-time', status: :active)
    create(:job_type, name: 'Internship', status: :active)
    create(:job_type, name: 'Senior', status: :archived)
    ExperienceLevel.create!(name: 'Junior')

    login_as user
    visit new_job_posting_path

    expect(page).to have_content 'Part-time'
    expect(page).to have_content 'Internship'
    expect(page).not_to have_content 'Senior'
  end
end
