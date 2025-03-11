require 'rails_helper'

describe 'User edits job_type', type: :request do
  it 'success' do
    admin = FactoryBot.create(:user, role: :admin)
    job_type = FactoryBot.create(:job_type, name: 'Estágio', active: true)

    request_login_as admin
    patch job_type_path(job_type.id), params: { job_type: {
      name: 'Pleno',
      active: false
    } }

    # p job_type.errors.full_messages
    expect(response).to redirect_to job_types_path
    expect(JobType.last.name).to eq 'Pleno'
    expect(JobType.last.active).to eq false
  end

  it 'user must be admin' do
    regular = FactoryBot.create(:user, role: :regular)
    job_type = FactoryBot.create(:job_type, name: 'Estágio', active: true)

    request_login_as regular
    patch job_type_path(job_type.id), params: { job_type: {
      name: 'Pleno',
      active: false
    } }

    expect(response).to redirect_to root_path
    expect(flash[:notice]).to eq 'Acesso não autorizado'
    expect(JobType.last.name).to eq 'Estágio'
    expect(JobType.last.active).to be true
  end

  it 'user must be authenticated' do
    job_type = FactoryBot.create(:job_type, name: 'Estágio', active: true)

    patch job_type_path(job_type.id), params: { job_type: {
      name: 'Pleno',
      active: false
    } }

    expect(response).to redirect_to new_session_path
    expect(JobType.last.name).to eq 'Estágio'
    expect(JobType.last.active).to be true
  end

  it 'name is required' do
    admin = FactoryBot.create(:user, role: :admin)
    job_type = FactoryBot.create(:job_type, name: 'Estágio', active: true)

    request_login_as(admin)
    patch job_type_path(job_type.id), params: { job_type: {
      name: '',
      active: false
    } }

    expect(flash[:alert]).to eq 'Não foi possível editar'
    expect(JobType.last.name).to eq 'Estágio'
    expect(JobType.last.active).to eq true
  end

  it 'active is required' do
    admin = FactoryBot.create(:user, role: :admin)
    job_type = FactoryBot.create(:job_type, name: 'Estágio', active: true)

    request_login_as(admin)
    patch job_type_path(job_type.id), params: { job_type: {
      name: 'Pleno',
      active: nil
    } }

    expect(flash[:alert]).to eq 'Não foi possível editar'
    expect(JobType.last.name).to eq 'Estágio'
    expect(JobType.last.active).to eq true
  end
end
