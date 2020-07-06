module ApplicationHelper
  def title
    if content_for?(:title)
      "#{content_for :title} | gnoteworthy"
    else
      default_title
    end
  end

  def default_title
    "gnoteworthy | Guard the treasures of your mind"
  end
end
