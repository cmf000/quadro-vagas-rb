FactoryBot.define do
  factory :user do
    name { 'João' }
    last_name { 'Silva' }
    email_address { 'joao@email.com' }
    password { 'password123' }
    password_confirmation { 'password123' }
  end
end
