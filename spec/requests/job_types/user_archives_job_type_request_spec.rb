require 'rails_helper'

describe 'User archives job_type', type: :request do
  it 'success' do
    admin = create(:user, role: :admin)
    job_type = create(:job_type, name: 'Estágio', status: :active)

    request_login_as admin
    patch archive_job_type_path(job_type)

    expect(response).to redirect_to job_types_path
    expect(JobType.last.name).to eq 'Estágio'
    expect(JobType.last.status).to eq 'archived'
  end

  it 'user must be admin' do
    regular = create(:user, role: :regular)
    job_type = create(:job_type, name: 'Estágio', status: :active)

    request_login_as regular
    patch archive_job_type_path(job_type)

    expect(response).to redirect_to root_path
    expect(flash[:notice]).to eq 'Acesso não autorizado'
    expect(JobType.last.name).to eq 'Estágio'
    expect(JobType.last.status).to eq 'active'
  end

  it 'user must be authenticated' do
    job_type = create(:job_type, name: 'Estágio', status: :active)

    patch archive_job_type_path(job_type)

    expect(response).to redirect_to new_session_path
    expect(JobType.last.name).to eq 'Estágio'
    expect(JobType.last.status).to eq 'active'
  end

  it 'job type is not registered' do
    admin = create(:user, role: :admin)

    request_login_as(admin)
    patch archive_job_type_path(999)

    expect(response).to redirect_to root_path
    expect(flash[:alert]).to eq 'Tipo de vaga não encontrado'
  end
end
