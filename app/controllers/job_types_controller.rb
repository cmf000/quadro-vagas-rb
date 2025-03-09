class JobTypesController < ApplicationController
  before_action :check_user_is_admin, only: [ :new ]
  def index
    @job_types = JobType.all
  end

  def new
    @job_type = JobType.new
  end

  def create
    @job_type = JobType.new(job_type_params)
    if @job_type.save
      flash[:notice] = "Tipo de vaga criada com sucesso"
      redirect_to job_types_path
    else
      flash.now[:alert] = "Something went wrong"
      render "new", status: :unprocessable_entity
    end
  end

  private
  def job_type_params
    params.require(:job_type).permit(:name, :active)
  end

  def check_user_is_admin
    redirect_to root_path, notice: "Acesso não autorizado" unless Current.user.admin?
  end
end
