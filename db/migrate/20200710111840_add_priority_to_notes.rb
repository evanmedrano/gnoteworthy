class AddPriorityToNotes < ActiveRecord::Migration[6.0]
  def change
    add_column :notes, :priority, :string
  end
end
