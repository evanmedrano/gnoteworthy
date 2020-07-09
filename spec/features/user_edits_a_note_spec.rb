require 'rails_helper'

feature "user edits a note" do
  scenario "successfully" do
    user = create(:user)
    note = create(:note, title: "My note", user: user)
    sign_in user
    visit "/dashboard"

    click_link "Edit"
    submit_form(title: "Edited note")

    expect(page).to have_content("Edited note")
  end

  scenario "with missing values" do
    user = create(:user)
    note = create(:note, title: "My note", user: user)
    sign_in user
    visit "/dashboard"

    click_link "Edit"
    submit_form(title: "", body: "")

    expect(page).to have_content("Title can't be blank")
  end

  scenario "which is private" do
    user = create(:user)
    note = create(:note, private: true, password: "foobar", user: user)
    sign_in user
    visit "/dashboard"

    click_link "Edit"
    authenticate_user
    submit_form(title: "Edited note")

    expect(page).to have_content("Edited note")
  end

  def submit_form(title: "Note title", body: "Note body")
    fill_in "Title", with: title
    fill_in "Body", with: body
    click_button "Edit note"
  end

  def authenticate_user
    fill_in "Enter password", with: "foobar"
    click_button "Submit"
  end
end
