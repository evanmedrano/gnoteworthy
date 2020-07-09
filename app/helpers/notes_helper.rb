module NotesHelper
  def note_creation_info(note)
    formatted_time = note.created_at.strftime("%a %I:%M")

    "(created by #{current_user.name}, #{formatted_time})"
  end
end
