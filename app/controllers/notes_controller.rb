class NotesController < ApplicationController
  before_action :authenticate_user!

  layout "dashboard"

  def new
    @note = Notes::FormService.new
  end

  def create
    @note = Notes::FormService.new(note_params)

    if @note.save
      redirect_to dashboard_path, notice: "Note saved."
    else
      flash.now[:alert] = "There was an error saving the note."
      render :new
    end
  end

  private

  def note_params
    params.require(:notes_form_service).
      permit(:body, :category, :password, :priority, :private, :title, :user_id)
  end
end
