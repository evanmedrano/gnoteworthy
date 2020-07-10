class Notes::RenderService
  def initialize(user, params = {})
    @user = user
    @params = params
  end

  def notes
    send("#{chosen_param}_notes")
  end

  private

  attr_reader :user, :params

  def chosen_param
    params.keys.first.to_s
  end

  def filter_notes
    user.notes.
      where("LOWER(category) = ? OR LOWER(urgency) = ?", filter, filter).
      order("LOWER(title) ASC")
  end

  def sort_notes
    case sort
    when "first_added"
      user.notes.order("created_at ASC")
    when "last_added"
      user.notes.order("created_at DESC")
    when "title"
      user.notes.order("LOWER(title) ASC")
    when "priority"
      user.notes.order("priority DESC, LOWER(title) ASC")
    when "category"
      user.notes.order("category ASC, LOWER(title) ASC")
    end
  end

  def filter
    params[:filter]
  end

  def sort
    params[:sort]
  end
end
