require 'rails_helper'

describe Notes::RenderService do
  describe "#notes" do
    context "when the option is sort_by" do
      context "when the sorting option is first_added" do
        it "orders the notes by created_at in ascending order" do
          user = create(:user)
          params = render_params(option: :sort, value: "first_added")
          3.times { |i| create(:note, title: "note#{i}", user: user) }

          render_service = described_class.new(user, params)

          note_titles = render_service.notes.map(&:title)
          expect(note_titles).to eq(["note0", "note1", "note2"])
        end
      end

      context "when the sorting option is last_added" do
        it "orders the notes by created_at in descending order" do
          user = create(:user)
          params = render_params(option: :sort, value: "last_added")
          3.times { |i| create(:note, title: "note#{i}", user: user) }

          render_service = described_class.new(user, params)

          note_titles = render_service.notes.map(&:title)
          expect(note_titles).to eq(["note2", "note1", "note0"])
        end
      end

      context "when the sorting option is title" do
        it "orders the notes by title alphabetically" do
          user = create(:user)
          params = render_params(option: :sort, value: "title")
          note1 = create(:note, user: user, title: "Zebra")
          note2 = create(:note, user: user, title: "Elephant")
          note3 = create(:note, user: user, title: "Giraffe")

          render_service = described_class.new(user, params)

          note_titles = render_service.notes.map(&:title)
          expect(note_titles).to eq(["Elephant", "Giraffe", "Zebra"])
        end
      end

      context "when the sorting option is priority" do
        it "orders the most urgent notes first" do
          user = create(:user)
          params = render_params(option: :sort, value: "priority")
          note1 = create(:note, user: user, urgency: "Medium", title: "med")
          note2 = create(:note, user: user, urgency: "Low", title: "low")
          note3 = create(:note, user: user, urgency: "Urgent", title: "urgent")

          render_service = described_class.new(user, params)

          note_titles = render_service.notes.map(&:title)
          expect(note_titles).to eq(["urgent", "med", "low"])
        end
      end

      context "when the sorting option is category" do
        it "orders the notes by category" do
          user = create(:user)
          params = render_params(option: :sort, value: "category")
          note1 = create(:note, user: user, category: "Work", title: "work")
          note2 = create(:note, user: user, category: "Personal", title: "pers")
          note3 = create(:note, user: user, category: "Work", title: "job")

          render_service = described_class.new(user, params)

          note_titles = render_service.notes.map(&:title)
          expect(note_titles).to eq(["pers", "job", "work"])
        end
      end
    end

    context "when the option is filter" do
      context "when the filter option is a category" do
        it "filters the notes by the category" do
          user = create(:user)
          params = render_params(option: :filter, value: "personal")
          2.times { create(:note, category: "Work", user: user) }
          create(:note, category: "Personal", user: user)

          render_service = described_class.new(user, params)

          expect(render_service.notes).to eq([Note.last])
        end
      end

      context "when the filter option is an urgency" do
        it "filters the notes by urgency" do
          user = create(:user)
          params = render_params(option: :filter, value: "low")
          2.times { create(:note, urgency: "High", user: user) }
          create(:note, urgency: "Low", user: user)

          render_service = described_class.new(user, params)

          expect(render_service.notes).to eq([Note.last])
        end
      end
    end
  end

  def render_params(option:, value:)
    { option => value }
  end
end
