require 'rails_helper'

describe 'User registers new job type', type: :request do
  it 'success' do
    admin = FactoryBot.create(:user, role: :admin)

    request_login_as admin
    post job_types_path params: { job_type: {
      name: 'Estágio',
      active: true
    } }

    expect(response).to redirect_to job_types_path
    expect(JobType.count).to eq 1
    expect(JobType.last.name).to eq 'Estágio'
    expect(JobType.last.active).to eq true
  end

  it 'user must be admin' do
    regular = FactoryBot.create(:user, role: :regular)

    request_login_as regular
    post job_types_path params: { job_type: {
      name: 'Estágio',
      active: true
    } }

    expect(response).to redirect_to root_path
    expect(flash[:notice]).to eq 'Acesso não autorizado'
    expect(JobType.count).to eq 0
  end

  it 'user must be authenticated' do
    post job_types_path params: { job_type: {
      name: 'Estágio',
      active: true
    } }

    expect(response).to redirect_to new_session_path
    expect(JobType.count).to eq 0
  end

  it 'name is required' do
    admin = FactoryBot.create(:user, role: :admin)

    request_login_as admin
    post job_types_path params: { job_type: {
      active: true
    } }

    expect(JobType.count).to eq 0
    expect(flash[:alert]).to eq 'Não foi possível criar o tipo de vaga'
  end

  it 'name must be unique' do
    admin = FactoryBot.create(:user, role: :admin)
    FactoryBot.create(:job_type, name: 'Estágio', active: true)

    request_login_as admin
    post job_types_path params: { job_type: {
      name: 'Estágio',
      active: true
    } }

    expect(JobType.count).to eq 1
    expect(flash[:alert]).to eq 'Não foi possível criar o tipo de vaga'
  end
end
