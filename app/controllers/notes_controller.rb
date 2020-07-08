class NotesController < ApplicationController
  before_action :authenticate_user!

  layout "dashboard"

  def new
    @note = Notes::FormService.new
  end

  def create
    @note = Notes::FormService.new(note_params)

    if @note.save
      redirect_with_notice
    else
      redirect_back_with_errors
    end
  end

  private

  def note_params
    params.require(:notes_form_service).
      permit(:body, :category, :password, :priority, :private, :title, :user_id)
  end

  def redirect_with_notice(notice: "Note saved.")
    redirect_to dashboard_path, notice: notice
  end

  def redirect_back_with_errors
    flash[:alert] = "Failed to save the note."
    flash[:note_errors] = @note.errors.full_messages
    redirect_back(fallback_location: root_url)
  end
end
