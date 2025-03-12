class JobPostingsController < ApplicationController
  allow_unauthenticated_access only: [ :show ]

  def show
    @job_posting = JobPosting.find(params[:id])
  end

  def new
    @job_posting = JobPosting.new
    @experience_levels = ExperienceLevel.all
    @job_types = JobType.where(status: :active)
  end

  def create
    @job_posting = JobPosting.new(job_posting_params)
    @job_posting.company_profile = Current.user.company_profile
    if @job_posting.save
      redirect_to root_path, notice: t(".success")
    else
      flash[:alert] = t(".failure")
      @experience_levels = ExperienceLevel.all
      @job_types = JobType.where(status: :active)
      render :new, status: :unprocessable_entity
    end
  end

  private

  def job_posting_params
    params.require(:job_posting).permit(:title, :salary, :salary_currency, :salary_period, :work_arrangement, :job_location, :job_type_id, :experience_level_id, :description)
  end
end
