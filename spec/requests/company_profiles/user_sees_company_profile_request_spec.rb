require 'rails_helper'

describe 'User tries to get the company profile page', type: :request do
  it 'and fails for being unauthenticated' do
    user = create(:user)
    company_profile = create(:company_profile, user: user)

    get(company_profile_path(company_profile))

    expect(response).to redirect_to new_session_path
    expect(response.status).to eq 302
  end

  it 'and fails because they still dont have one' do
    user = create(:user)
    cookie_jar = ActionDispatch::Request.new(Rails.application.env_config.deep_dup).cookie_jar
    user.sessions.create!.tap do |session|
      cookie_jar.signed.permanent[:session_id] = { value: session.id, httponly: true, samesite: :lax }
      cookies[:session_id] = cookie_jar[:session_id]
    end

    get(company_profile_path(id: 1))

    expect(response).to redirect_to new_company_profile_path
    expect(response.status).to eq 302
  end
end
