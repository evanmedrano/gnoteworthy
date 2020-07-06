require 'rails_helper'

feature "User signs up" do
  scenario "with valid parameters" do
    visit "/users/sign_up"

    expect { submit_form }.to change(User, :count).by(1)
  end

  scenario "with invalid parameters" do
    visit "/users/sign_up"

    submit_form(email: "")

    expect(page).to have_content("Email can't be blank")
  end

  scenario "with a taken email" do
    user = create(:user)
    visit "/users/sign_up"

    submit_form(email: user.email)

    expect(page).to have_content("Email has already been taken")
  end

  def submit_form(email: "test@example.com")
    fill_in "Email", with: email
    fill_in "Name", with: "Test User"
    fill_in "Password", with: "foobar"
    fill_in "Password confirmation", with: "foobar"
    click_button "Sign up"
  end
end
