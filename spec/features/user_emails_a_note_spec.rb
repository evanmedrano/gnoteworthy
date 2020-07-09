require 'rails_helper'

feature "user emails a note" do
  include ::ActiveJob::TestHelper

  scenario "from the dashboard" do
    user = create(:user)
    note = create(:note, user: user)
    sign_in user
    visit "/dashboard"

    click_button "Email"

    expect(page).to have_content("Email sent.")
    expect(ActiveJob::Base.queue_adapter.enqueued_jobs.count).to eq(1)
  end

  scenario "from the show page" do
    user = create(:user)
    note = create(:note, user: user)
    sign_in user
    visit "/dashboard/notes/#{note.id}"

    click_button "Email"

    expect(page).to have_content("Email sent.")
    expect(ActiveJob::Base.queue_adapter.enqueued_jobs.count).to eq(1)
  end
end
