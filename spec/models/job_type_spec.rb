require 'rails_helper'

RSpec.describe JobType, type: :model do
  describe '#Valid?' do
    context 'Nome' do
      it { should validate_presence_of(:name) }
      it { should validate_uniqueness_of(:name) }
    end
  end
end
