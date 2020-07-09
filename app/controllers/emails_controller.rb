class EmailsController < ApplicationController
  def create
    email = Notes::EmailService.new(email_params)

    if email.deliver
      redirect_with_notice
    else
      redirect_with_errors
    end
  end

  private

  def email_params
    params.require(:notes_email_service).permit(:user_id, :note_id)
  end

  def redirect_with_notice
    flash[:notice] = "Email sent."
    redirect_back(fallback_location: root_url)
  end

  def redirect_with_errors
    flash[:alert] = "Failed to send email."
    redirect_back(fallback_location: root_url)
  end
end
