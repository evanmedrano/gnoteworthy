class Note < ApplicationRecord
  include NoteValidations

  has_secure_password validations: false

  belongs_to :user, touch: true
end
