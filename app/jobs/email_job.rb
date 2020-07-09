class EmailJob < ApplicationJob
  queue_as :default

  def perform(note)
    NoteMailer.send_note(note).deliver_later
  end
end
