require 'rails_helper'

feature "user views a note" do
  scenario "which is private" do
    user = create(:user)
    note = create(:note, private: true, password: "foobar", user: user)
    sign_in user
    visit "/dashboard"

    click_link "View"
    authenticate_user

    expect(page).to have_content(note.title)
  end

  def authenticate_user
    fill_in "Enter password", with: "foobar"
    click_button "Submit"
  end
end
