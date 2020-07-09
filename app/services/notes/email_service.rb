class Notes::EmailService
  include ActiveModel::Model

  attr_accessor :note_id

  def deliver
    if valid?
      EmailJob.perform_later(note)
      true
    else
      false
    end
  end

  private

  def note
    Note.find_by(id: note_id)
  end

  def user
    note.user
  end
end
