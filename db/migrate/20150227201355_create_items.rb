class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.text :description, null: false
      t.timestamp :completed_at

      t.timestamps null: false
    end
  end
end
