require 'rails_helper'

describe 'User tries to create a company profile', type: :request do
  context 'and fails to get the form ' do
    it 'for not being authenticated' do
      get(new_company_profile_path)

      expect(response).to redirect_to new_session_path
      expect(response.status).to eq 302
    end

    it 'because they already have a company profile' do
      user = create(:user)
      create(:company_profile, user: user)
      cookie_jar = ActionDispatch::Request.new(Rails.application.env_config.deep_dup).cookie_jar
      user.sessions.create!.tap do |session|
        cookie_jar.signed.permanent[:session_id] = { value: session.id, httponly: true, samesite: :lax }
        cookies[:session_id] = cookie_jar[:session_id]
      end

      get(new_company_profile_path)

      expect(response).to redirect_to root_path
      expect(response.status).to eq 302
    end
  end

  context 'and fails to create a company profile through a post request' do
    it 'for being unauthenticated' do
      user = create(:user)
      create(:company_profile, user: user)
      file = Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'files', 'logo.jpg'), 'image/jpg')

      post(company_profiles_path, params: { company_profile: {
        name: 'Company',
        contact_email: 'contact@company.com',
        website_url: 'https://company.com',
        logo: file
      } })

      expect(response).to redirect_to new_session_path
      expect(response.status).to eq 302
    end

    it 'because they already have one' do
      user = create(:user)
      create(:company_profile, user: user)
      cookie_jar = ActionDispatch::Request.new(Rails.application.env_config.deep_dup).cookie_jar
      user.sessions.create!.tap do |session|
        cookie_jar.signed.permanent[:session_id] = { value: session.id, httponly: true, samesite: :lax }
        cookies[:session_id] = cookie_jar[:session_id]
      end
      file = Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'files', 'logo.jpg'), 'image/jpg')

      post(company_profiles_path, params: { company_profile: {
        name: 'Company',
        contact_email: 'contact@company.com',
        website_url: 'https://company.com',
        logo: file
      } })

      expect(response).to redirect_to root_path
      expect(response.status).to eq 302
    end
  end
end
