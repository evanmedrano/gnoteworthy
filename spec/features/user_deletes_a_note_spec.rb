require 'rails_helper'

feature "user deletes a note" do
  scenario "successfully" do
    user = create(:user)
    note = create(:note, user: user)
    sign_in user
    visit "/dashboard"

    click_link "Delete"

    expect(page).to have_content("Note deleted.")
    expect(user.notes.count).to eq(0)
  end
end
