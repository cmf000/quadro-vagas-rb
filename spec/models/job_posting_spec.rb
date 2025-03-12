require 'rails_helper'

RSpec.describe JobPosting, type: :model do
  context "#Valid?" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:salary) }
    it { should validate_presence_of(:salary_currency) }
    it { should validate_presence_of(:salary_period) }
    it { should validate_presence_of(:job_type) }
    it { should belong_to :company_profile }
    it { should belong_to :job_type }
    it { should validate_presence_of(:description) }
  end

  context ".tag_list" do
    it "should be unique" do
      job_posting = create(:job_posting)
      job_posting.tag_list.add('teste')
      job_posting.save

      job_posting.tag_list.add('teste')
      job_posting.save

      expect(job_posting.tag_list.count).to eq 1
    end

    it "should have 3 tags maximum" do
      job_posting = create(:job_posting)
      job_posting.tag_list = ['Ruby', 'Dev Jr', 'Scrum']
      job_posting.save

      job_posting.tag_list.add('teste')

      expect(job_posting).not_to be_valid
    end
  end
end
