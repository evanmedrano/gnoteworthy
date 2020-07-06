require 'rails_helper'

feature "User logs out" do
  scenario "successfully" do
    sign_in create(:user)
    visit "/"

    click_link "Log out"

    expect(page).to have_content("Log in")
  end
end
