class Note < ApplicationRecord
  include NoteValidations

  has_secure_password validations: false

  belongs_to :user, touch: true

  def public?
    !private?
  end
end
