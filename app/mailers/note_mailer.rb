class NoteMailer < ApplicationMailer
  default from: "no-reply@gnoteworthy.com"

  def send_note(note)
    @note = note
    @user = note.user

    mail(
      to: @user.email,
      subject: "Your note: '#{@note.title}' – courtesy of gnoteworthy"
    )
  end
end
