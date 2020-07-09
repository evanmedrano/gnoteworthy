require 'rails_helper'

feature "user emails a note" do
  scenario "successfully" do
    user = create(:user)
    note = create(:note, user: user)
    sign_in user
    visit "/dashboard"

    click_button "Email"

    expect(ActionMailer::Base.deliveries.count).to eq(1)
  end
end
