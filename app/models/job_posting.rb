class JobPosting < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_jobs,
                  against:  [ :title, :description ],
                  using: {
                    trigram: {
                      word_similarity: true
                    }
                  }

  acts_as_taggable_on :tags

  belongs_to :company_profile
  belongs_to :job_type

  validates :title, :salary, :salary_currency, :salary_period, :company_profile, :job_type, :description, presence: true
  validate :job_posting_has_maximum_tags

  MAXIMUM_TAGS = 3
  
  def maximum_tags
    tag_list.size < MAXIMUM_TAGS 
  end

  private

  def job_posting_has_maximum_tags
    if tag_list.count > MAXIMUM_TAGS
      errors.add(:tag_list, I18n.t('errors.maximum_tag_error'))
    end
  end
end
