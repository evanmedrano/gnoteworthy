class NotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_note, only: [:show, :edit, :update, :destroy]

  layout "dashboard"

  def new
    @note = Note.new
  end

  def edit
  end

  def create
    @note = Notes::FormService.new(note_params)

    if @note.save
      redirect_with_notice
    else
      redirect_back_with_errors
    end
  end

  def update
    if @note.update(note_params)
      redirect_with_notice
    else
      redirect_back_with_errors
    end
  end

  private

  def set_note
    @note = Note.find_by(id: params[:id])
  end

  def note_params
    params.require(:note).
      permit(:body, :category, :password, :priority, :private, :title, :user_id)
  end

  def redirect_with_notice
    redirect_to dashboard_path, notice: "Note saved."
  end

  def redirect_back_with_errors
    flash[:alert] = "Failed to save the note."
    flash[:note_errors] = @note.errors.full_messages
    redirect_back(fallback_location: root_url)
  end
end
