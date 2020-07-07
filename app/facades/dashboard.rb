class Dashboard
  def initialize(user)
    @user = user
  end

  def notes
    user.notes
  end

  private

  attr_reader :user
end
