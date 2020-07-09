class Note < ApplicationRecord
  include NoteValidations

  before_save :assign_note_title?

  has_secure_password validations: false

  belongs_to :user, touch: true

  def public?
    !private?
  end

  def urgent?
    urgency == "High" || urgency == "Urgent"
  end

  def new_email
    @new_email ||= Notes::EmailService.new
  end

  private

  def assign_note_title?
    self.title = self.body[0...30] if self.title.blank?
  end
end
