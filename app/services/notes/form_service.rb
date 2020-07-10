class Notes::FormService
  include ActiveModel::Model
  include NoteValidations

  attr_accessor :body,
                :category,
                :email,
                :password,
                :priority,
                :private,
                :title,
                :urgency,
                :user_id

  def save
    if valid?
      save_note
      send_email if email_requested?
      true
    else
      false
    end
  end

  private

  def save_note
    assign_note_attribute_values
    note.save
  end

  def send_email
    EmailJob.perform_later(note)
  end

  def email_requested?
    email == "true"
  end

  def assign_note_attribute_values
    self.instance_values.each do |name, value|
      next if name == "email"
      note.send("#{name}=", value) if respond_to?("#{name}=")
    end

    assign_note_title?
    note.user_id = user_id
  end

  def assign_note_title?
    note.title = note.body[0...30] if note.title.blank?
  end

  def note
    @note ||= Note.new
  end
end
