class Note < ApplicationRecord
  include NoteValidations
  before_save :assign_note_title?
  before_save :update_priority
  has_secure_password validations: false

  belongs_to :user, touch: true

  enum priority: ["Whenever", "Low", "Medium", "High", "Urgent"]

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

  def update_priority
    self.priority = self.urgency
  end
end
