require 'rails_helper'
require 'concerns/note_validations_spec'

describe Notes::FormService, type: :service do
  context "validations" do
    it_behaves_like "note validations"
  end

  describe "#save" do
    context "with a valid note" do
      it "saves the note to the database" do
        user = create(:user)

        note_service = described_class.new(params(user_id: user.id))

        expect { note_service.save }.to change(Note, :count).by(1)
      end
    end
  end

  def params(user_id:, title: "Note title", body: "Note body")
    {
      body: body,
      category: "Work",
      priority: "High",
      private: false,
      title: title,
      user_id: user_id,
    }
  end
end
