class NotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_note, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user, only: [:show, :edit]
  before_action :authenticate_password, only: [:show, :edit]

  layout "dashboard"

  def new
    @note = Note.new
  end

  def show
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

  def destroy
    if @note.destroy
      redirect_with_notice(notice: "Note deleted.")
    else
      redirect_back_with_errors(alert: "Failed to delete the message.")
    end
  end

  private

  def set_note
    @note = Note.find_by!(id: params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to "/whoops"
  end

  def authorize_user
    if @note.user != current_user
      redirect_to "/whoops"
    end
  end

  def authenticate_password
    return if @note.public?

    if @note.authenticate(params[:password])
      session[:authenticated] = true
      redirect_back(fallback_location: root_url)
    elsif incorrect_password?
      redirect_back_with_errors(alert: "Incorrect password.")
    end
  end

  def note_params
    params.require(:note).
      permit(
        :body, :category, :password, :priority, :urgency, :private, :title, :user_id, :email
      )
  end

  def redirect_with_notice(notice: "Note saved.")
    redirect_to dashboard_url, notice: notice
  end

  def redirect_back_with_errors(alert: "Failed to save the note.")
    flash[:alert] = alert
    flash[:note_errors] = @note.errors.full_messages
    redirect_back(fallback_location: root_url)
  end

  def incorrect_password?
    params[:password] && !@note.authenticate(params[:password])
  end
end
