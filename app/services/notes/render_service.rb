class Notes::RenderService
  def initialize(user, sorting_option = "")
    @user = user
    @sorting_option = sorting_option
  end

  def notes
    case sorting_option
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
    else
      user.notes
    end
  end

  private

  attr_reader :user, :sorting_option
end
