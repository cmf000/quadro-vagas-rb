require "rails_helper"

RSpec.describe 'User visits home page', type: :system, js: true do
  it 'success' do
    visit root_path

    sleep 1

    expect(page).to have_content "Hello World!"
  end
end
