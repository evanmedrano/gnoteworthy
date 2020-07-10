require 'rails_helper'

describe "Errors", type: :request do

  describe "#show" do
    it "displays when a user tries to visit a non-existing route" do
      get "/my-non-existing-route"

      expect(response.body).to include("Oh no!")
    end
  end
end
