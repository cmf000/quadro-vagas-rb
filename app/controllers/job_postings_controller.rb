class JobPostingsController < ApplicationController
  allow_unauthenticated_access

  def show
    @job_posting = JobPosting.find(params[:id])
  end
end
