class TagsController < ApplicationController
  before_action :set_job_posting
  before_action :job_posting_has_maximum_tags?
  before_action :tag_is_uniq, only: %i[ create ]

  def new
    @job_posting = JobPosting.find(params[:job_posting_id])
  end

  def create
    return redirect_to @job_posting, notice: t('.create_tag') if @job_posting.save

    flash.now[:alert] = t('.create_tag_fail')
    render :new, status: :unprocessable_entity
  end

  private

  def set_job_posting
    @job_posting = JobPosting.find(params[:job_posting_id])
  end

  def tag_is_uniq
    if @job_posting.tag_list.size == @job_posting.tag_list.add(params[:tag_name]).size
      return redirect_to new_job_posting_tag_path(@job_posting), alert: t('.tag_must_be_unique')
    end
  end

  def job_posting_has_maximum_tags?
    redirect_to job_posting_path(@job_posting), alert: t('.job_posting_has_maximum_tags') unless @job_posting.maximum_tags
  end
end