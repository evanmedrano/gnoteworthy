module NoteValidations
  extend ActiveSupport::Concern

  included do
    validates :body, length: { maximum: 1000 }
    validates :title, length: { maximum: 30 }
    validates :user_id, presence: true

    with_options if: -> { content_is_blank? } do |note|
      note.validates :title, presence: true
    end

    with_options if: -> { note_is_private? } do |note|
      note.validates :password, presence: true, length: { minimum: 6 }
    end

    private

    def content_is_blank?
      body.blank? && title.blank?
    end

    def note_is_private?
      # the first branch is to handle updating notes in the db
      # the second branch handles the creation of notes via the form service

      if respond_to?(:password_digest)
        is_private? && password_digest.nil?
      else
        is_private?
      end
    end

    def is_private?
      (private == true || private == "true")
    end
  end
end
