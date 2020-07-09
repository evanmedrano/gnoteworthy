class DashboardsController < ApplicationController
  before_action :authenticate_user!
  before_action :clear_session

  layout "dashboard"

  def show
    @dashboard = Dashboard.new(current_user)
  end
end
