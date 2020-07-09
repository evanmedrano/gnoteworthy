module DashboardsHelper
  def urgency(note)
    if note.urgent?
      "note__urgency--red"
    end
  end

  def grid_styles
    "fas fa-th-large d-none d-md-inline-block mr-auto dashboard__view--active"
  end

  def row_styles
    "fas fa-square d-none d-md-inline-block mr-2 dashboard__view"
  end
end
