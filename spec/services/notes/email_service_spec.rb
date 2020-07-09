require 'rails_helper'

describe Notes::EmailService do
  include ::ActiveJob::TestHelper

  describe "#send" do
    it "queues a job to send an email" do
      email = described_class.new(email_params)

      expect {
        email.deliver
      }.to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :count).by(1)
    end
  end

  def email_params
    { note_id: create(:note).id }
  end
end
