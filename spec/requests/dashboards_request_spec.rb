require 'rails_helper'

describe "Dashboards" do
  describe "#show" do
    context "when a user is not logged in" do
      it "redirects user to the login screen" do
        get "/dashboard"

        expect(response).to redirect_to("/users/sign_in")
      end
    end

    context "when a user is logged in" do
      it "returns http success" do
        get "/dashboard", as: sign_in(create(:user))

        expect(response).to have_http_status(:success)
      end
    end
  end
end
