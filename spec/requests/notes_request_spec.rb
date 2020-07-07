require 'rails_helper'

describe "Notes" do
  describe "#create" do
    context "with valid parameters" do
      it "saves a note to the database" do
        sign_in create(:user)

        expect { post "/dashboard/notes", params: params }.to change(Note, :count).by(1)
      end

      it "saves a new note for the current_user" do
        user = create(:user)
        sign_in user

        post "/dashboard/notes", params: params

        expect(user.notes.count).to eq(1)
      end
    end

    context "with invalid parameters" do
      it "does not save a note to the database" do
        sign_in create(:user)

        post "/dashboard/notes", params: params(title: "", body: "")

        expect(Note.count).to eq(0)
      end
    end

    context "with no body present" do
      it "saves a note to the database" do
        sign_in create(:user)

        post "/dashboard/notes", params: params(body: "")

        expect(Note.count).to eq(1)
      end
    end

    context "with no title present" do
      it "saves the note & the title is the first 30 characters of the body" do
        sign_in create(:user)

        post "/dashboard/notes", params: params(title: "")

        expect(Note.count).to eq(1)
        expect(Note.first.title).to eq("Note body")
      end
    end
  end

  def params(user_id: created_user_id, title: "Note title", body: "Note body")
    {
      notes_form_service: {
        body: body,
        category: "Work",
        priority: "High",
        private: false,
        title: title,
        user_id: user_id,
      }
    }
  end

  def created_user_id
    User.first.id
  end
end
