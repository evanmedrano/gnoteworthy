class CreateNotes < ActiveRecord::Migration[6.0]
  def change
    create_table :notes do |t|
      t.references :user, null: false, foreign_key: true
      t.boolean :private, default: false
      t.string :category
      t.string :password_digest
      t.string :priority
      t.string :title, default: ""
      t.text :body, default: ""

      t.timestamps
    end
  end
end
