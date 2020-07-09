class RenamePriorityToUrgencyInNotes < ActiveRecord::Migration[6.0]
  def change
    rename_column :notes, :priority, :urgency
  end
end
