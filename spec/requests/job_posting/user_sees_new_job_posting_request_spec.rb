require 'rails_helper'

describe 'User tries to see new job post page', type: :request do
  it 'and fails for being unauthenticated' do
    get(new_job_posting_path)

    expect(response).to redirect_to new_session_path
    expect(response.status).to eq 302
  end
end
