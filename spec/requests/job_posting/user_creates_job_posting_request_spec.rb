require 'rails_helper'

describe 'User tries to create job post', type: :request do
  it 'and fails for not being authenticated' do
    post(job_postings_path, params: { job_posting: {
        title: 'Desenvolvedor'
      } })

    expect(response).to redirect_to new_session_path
    expect(response.status).to eq 302
  end
end
