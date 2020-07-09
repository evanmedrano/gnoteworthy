require 'rails_helper'

describe "Notes" do
  describe "#new" do
    context "when a user is logged in" do
      it "returns http success" do
        sign_in create(:user)

        get "/dashboard/notes/new"

        expect(response).to have_http_status(:success)
      end
    end

    context "when a user is not logged in" do
      it "returns http success" do
        get "/dashboard/notes/new"

        expect(response).to redirect_to("/users/sign_in")
      end
    end
  end

  describe "#edit" do
    context "when a user is logged in" do
      it "returns http success" do
        note = create(:note)
        sign_in create(:user)

        get "/dashboard/notes/#{note.id}/edit"

        expect(response).to have_http_status(:success)
      end
    end

    context "when a user is not logged in" do
      it "returns http success" do
        note = create(:note)

        get "/dashboard/notes/#{note.id}/edit"

        expect(response).to redirect_to("/users/sign_in")
      end
    end
  end

  describe "#create" do
    context "with valid parameters" do
      it "saves a note to the database" do
        sign_in create(:user)

        expect {
          post "/dashboard/notes", params: params
        }.to change(Note, :count).by(1)
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

  describe "#update" do
    context "when the params are valid" do
      it "updates the note" do
        note = create(:note, title: "My note")
        sign_in create(:user)

        patch "/dashboard/notes/#{note.id}", params: params(title: "TODO")

        expect(note.reload.title).to eq("TODO")
      end
    end

    context "when the params are invalid" do
      it "does not update the note" do
        note = create(:note, private: false)
        sign_in create(:user)

        patch "/dashboard/notes/#{note.id}", params: params(private: "true")

        expect(note.reload.private).to eq(false)
      end
    end

    context "with no title present" do
      it "saves the note & the title is the first 30 characters of the body" do
        user = create(:user)
        note = create(:note, user: user, body: "Note body", title: "Hey there")
        sign_in user

        patch "/dashboard/notes/#{note.id}", params: params(title: "")

        expect(note.reload.title).to eq("Note body")
      end
    end
  end

  describe "#delete" do
    it "deletes the note from the database" do
      user = create(:user)
      note = create(:note, user: user)
      sign_in user

      expect {
        delete "/dashboard/notes/#{note.id}"
      }.to change(Note, :count).by(-1)
    end
  end

  def params(user_id: created_user_id, **args)
    {
      note: {
        body: args[:body] || "Note body",
        category: "Work",
        priority: "High",
        private: args[:private] || false,
        title: args[:title] || "Note title",
        user_id: user_id,
      }
    }
  end

  def created_user_id
    User.first.id
  end
end
