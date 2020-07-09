class Notes::FormService
  include ActiveModel::Model
  include NoteValidations

  attr_accessor :body,
                :category,
                :password,
                :private,
                :title,
                :urgency,
                :user_id

  def save
    if valid?
      save_note
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

  def assign_note_attribute_values
    self.instance_values.each do |name, value|
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
