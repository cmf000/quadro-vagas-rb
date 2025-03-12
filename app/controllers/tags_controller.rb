class TagsController < ApplicationController
  before_action :set_job_posting
  before_action :tag_validation, only: %i[ create ]
  before_action :job_posting_has_maximum_tags?

  def new; end

  def create
    return redirect_to @job_posting, notice: t('.create_tag') if @job_posting.save

    flash.now[:alert] = t('.create_tag_fail')
    render :new, status: :unprocessable_entity
  end

  private

  def set_job_posting
    @job_posting = JobPosting.find(params[:job_posting_id])
  end

  def job_posting_has_maximum_tags?
    redirect_to job_posting_path(@job_posting), alert: t('.job_posting_has_maximum_tags') unless @job_posting.maximum_tags
  end

  def tag_validation
    return render :new, status: :unprocessable_entity if tag_is_blank? || tag_is_unique?
    @job_posting.tag_list.add(params[:tag_list])
  end

  def tag_is_blank?
    unless params[:tag_list].present?
      flash.now[:alert] = t('.tag_is_empty')
      return true
    end
  end
  
  def tag_is_unique?
    if params[:tag_list].downcase.in?(@job_posting.tag_list)
      flash.now[:alert] = t('.tag_must_be_unique')
      return true
    end
  end
end