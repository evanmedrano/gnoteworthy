class Dashboard
  def initialize(user, params = {})
    @user = user
    @params = params
  end

  def notes
    if params[:sort_by]
      Notes::RenderService.new(user, sorting_option).notes
    else
      user.notes
    end
  end

  private

  attr_reader :user, :params

  def sorting_option
    params[:sort_by]
  end
end
