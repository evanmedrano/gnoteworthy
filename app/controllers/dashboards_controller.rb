class DashboardsController < ApplicationController
  before_action :authenticate_user!

  layout "dashboard"

  def show
    @dashboard = Dashboard.new(current_user)
  end
end
