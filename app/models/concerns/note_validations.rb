module NoteValidations
  extend ActiveSupport::Concern

  included do
    validates :body, length: { maximum: 1000 }
    validates :title, length: { maximum: 30 }
    validates :user_id, presence: true

    with_options if: -> { body.blank? } do |note|
      note.validates :title, presence: true
    end

    with_options if: -> { private? } do |note|
      note.validates :password, presence: true, length: { minimum: 6 }
    end

    private

    def private?
      private == true
    end
  end
end
