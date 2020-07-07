require 'rails_helper'
require 'concerns/note_validations_spec'

describe Note do
  context "associations" do
    it { should belong_to(:user).touch(true) }
  end

  context "validations" do
    it_behaves_like "note validations"
  end
end
