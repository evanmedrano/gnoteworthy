# Preview all emails at http://localhost:3000/rails/mailers/note_mailer
class NoteMailerPreview < ActionMailer::Preview
  def send_note
    NoteMailer.send_note(Note.first)
  end
end
