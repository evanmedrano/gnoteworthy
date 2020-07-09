require "rails_helper"

describe NoteMailer do
  describe "#send_note" do
    it "sends the email to the note's user" do
      note = create(:note)
      user = note.user

      described_class.send_note(note).deliver_now

      mail = ActionMailer::Base.deliveries.first
      expect([user.email]).to eq(mail.to)
    end

    it "includes the note's title in the subject" do
      note = create(:note)

      described_class.send_note(note).deliver_now

      mail = ActionMailer::Base.deliveries.first
      expect(mail.subject).to include(note.title)
    end

    it "includes the note's body in the email's body" do
      note = create(:note)

      described_class.send_note(note).deliver_now

      mail = ActionMailer::Base.deliveries.first
      expect(mail.body).to include(note.body)
    end
  end
end
