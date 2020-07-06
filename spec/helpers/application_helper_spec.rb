require 'rails_helper'

describe ApplicationHelper do
  describe "#title" do
    context "when no argument is given" do
      it "returns the default title" do
        expect(helper.title).to eq(helper.default_title)
      end
    end

    context "when an argument is given" do
      it "returns the argument plus ' | gnoteworthy' at the end" do
        helper.content_for(:title, "Sign up")

        expect(helper.title).to eq("Sign up | gnoteworthy")
      end
    end
  end
end
