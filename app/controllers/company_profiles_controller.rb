class CompanyProfilesController < ApplicationController
  before_action :redirect_to_root_if_user_already_has_a_company_profile, only: [ :new, :create ]
  before_action :redirect_to_new_if_user_has_no_company_profile, only: [ :show ]
  def new
    @company_profile = CompanyProfile.new
  end

  def create
    @company_profile = Current.user.build_company_profile(company_profile_params)

    if @company_profile.save
      redirect_to company_profile_path(@company_profile), notice: t(".success")
    else
      @company_profile.user = nil
      flash.now[:alert] = t(".failure")
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @company_profile = Current.user.company_profile
  end

  private
  def redirect_to_root_if_user_already_has_a_company_profile
    redirect_to root_path, alert: t(".user_already_has_a_company_profile") if Current.user.company_profile.present?
  end

  def redirect_to_new_if_user_has_no_company_profile
    redirect_to new_company_profile_path unless Current.user.company_profile.present?
  end


  def company_profile_params
    params.require(:company_profile).permit(:name, :website_url, :contact_email, :logo)
  end
end
