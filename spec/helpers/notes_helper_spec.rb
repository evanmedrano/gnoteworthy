require 'rails_helper'

describe NotesHelper do
  describe "#note_creation_info" do
    it "returns the current user's name within the string" do
      user = create(:user)
      note = create(:note, user: user)

      allow(helper).to receive(:current_user).and_return(user)

      expect(helper.note_creation_info(note)). to include(user.name)
    end

    it "returns a formatted created_at time" do
      user = create(:user)
      note = create(:note, user: user, created_at: Time.current)

      allow(helper).to receive(:current_user).and_return(user)
      formatted_time = note.created_at.strftime("%a %I:%M")

      expect(helper.note_creation_info(note)). to include(formatted_time)
    end
  end
end
