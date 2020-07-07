require 'rails_helper'

feature "user creates a new note" do
  scenario "successfully" do
    user = create(:user)
    sign_in user
    visit "/dashboard"

    click_link "New note"
    submit_form

    expect(user.notes.count).to eq(1)
    expect(Note.count).to eq(1)
    expect(page).to have_content(Note.first.title)
  end

  scenario "with missing values" do
    user = create(:user)
    sign_in user
    visit "/dashboard"

    click_link "New note"
    submit_form(title: "", body: "")

    expect(Note.count).to eq(0)
    expect(page).to have_content("Title can't be blank")
  end

  def submit_form(title: "Note note", body: "Note body")
    fill_in "Title", with: title
    fill_in "Body", with: body
    click_button "Add note"
  end
end
