require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#valid?" do
    context "presence" do
      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:last_name) }
      it { should validate_presence_of(:email_address) }
      it { should validate_presence_of(:password) }
      it { should validate_presence_of(:password_confirmation) }
    end

    context 'uniqueness' do
      subject { create(:user) }
      it { should validate_uniqueness_of(:email_address).case_insensitive }
    end

    context 'length' do
      it { should validate_length_of(:password).is_at_least(6) }
    end

    context 'format' do
      it { should allow_value('user@example.com').for(:email_address) }
      it { should_not allow_value('userexample').for(:email_address) }
      it { should_not allow_value('user@example').for(:email_address) }
    end
  end

  describe 'enum' do
    it { should define_enum_for(:role).with_values(regular: 0, admin: 10) }

    it "has default role as costumer" do
      user = User.new
      expect(user.role).to eq("regular")
    end
  end
end
