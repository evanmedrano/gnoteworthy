class Dashboard
  def initialize(user, params = {})
    @user = user
    @params = params
  end

  def notes
    if params_given?
      Notes::RenderService.new(user, params).notes
    else
      user.notes
    end
  end

  private

  attr_reader :user, :params

  def params_given?
    params[:sort] || params[:filter]
  end
end
