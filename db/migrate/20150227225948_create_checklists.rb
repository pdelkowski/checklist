class CreateChecklists < ActiveRecord::Migration
  def change
    create_table :checklists do |t|
      t.string :name, null: false
      t.timestamp :completed_at

      t.timestamps null: false
    end
  end
end
