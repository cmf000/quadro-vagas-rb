class RegistrationsController < ApplicationController
  allow_unauthenticated_access

  def new
    @user = User.new
  end

  def create
    @user = User.new(registration_params)
    if @user.save
      flash[:notice] = t(".success")
      after_registration_url
    else
      flash.now[:alert] = t(".alert")
      render :new, status: :unprocessable_entity
    end
  end

  private

  def registration_params
    params.require(:user).permit(:name, :last_name, :email_address, :password, :password_confirmation)
  end

  def after_registration_url
    user = User.authenticate_by(email_address: registration_params[:email_address], password: registration_params[:password])
    start_new_session_for user
    redirect_to after_authentication_url
  end
end
