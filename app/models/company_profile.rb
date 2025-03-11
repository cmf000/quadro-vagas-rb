class CompanyProfile < ApplicationRecord
  belongs_to :user
  has_many :job_postings, dependent: :destroy

  enum :status, { active: 0, inactive: 1 }

  default_scope { where(status: :active) }

  has_one_attached :logo

  validates :name, :website_url, :contact_email, :logo, presence: true
  validates :contact_email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i }
  validates :website_url, format: { with: /\Ahttps?:\/\/([a-z0-9\-]+\.)+[a-z]{2,6}\z/i, message: I18n.t("errors.messages.invalid_url_format") }
  validates :user, :contact_email, uniqueness: true
  validate :logo_image_type
  validate :contact_email_is_not_equal_to_any_registered_user_email, if: :user_and_contact_email_present?

  def activate!
    update!(status: :active)
    JobPosting.unscoped.where(company_profile_id: id).update_all(status: :active)
  end

  def deactivate!
    update!(status: :inactive)
    job_postings.update_all(status: :inactive)
  end

  private
  def logo_image_type
    allowed_types = [ "image/png", "image/jpeg", "image/jpg" ]

    errors.add(:logo, I18n.t("errors.messages.invalid_image_format")) unless self.logo.content_type.in?(allowed_types)
  end

  def user_and_contact_email_present?
    self.contact_email.present? && self.user.present?
  end

  def contact_email_is_not_equal_to_any_registered_user_email
    if User.exists?(email_address: self.contact_email)
      if self.user.email_address == self.contact_email
        errors.add(:contact_email, I18n.t("errors.messages.invalid_email_equals_user_email"))
      else
        errors.add(:contact_email, I18n.t("errors.messages.invalid_email_already_registered"))
      end
    end
  end
end
