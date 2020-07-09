require 'rails_helper'

describe DashboardsHelper do
  describe "#urgency" do
    it "returns red for high and urgent notes" do
      note1 = build_stubbed(:note, urgency: "High")
      note2 = build_stubbed(:note, urgency: "Urgent")

      expect(helper.urgency(note1)). to eq("note__urgency--red")
      expect(helper.urgency(note2)). to eq("note__urgency--red")
    end
  end
end
