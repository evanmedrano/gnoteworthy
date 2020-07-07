require 'rails_helper'

feature "User logs in" do
  scenario "with valid parameters" do
    user = create(:user)
    visit "/users/sign_in"

    submit_form(email: user.email, password: user.password)

    expect(page).to have_content("Log out")
    expect(page).to have_content "New note"
  end

  scenario "with invalid parameters" do
    visit "/users/sign_in"

    submit_form(email: "", password: "")

    expect(page).to have_content("Invalid Email or password")
  end

  def submit_form(email:, password:)
    fill_in "Email", with: email
    fill_in "Password", with: password
    click_button "Log in"
  end
end
