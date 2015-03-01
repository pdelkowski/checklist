class AddChecklistIdToItem < ActiveRecord::Migration
  def change
    add_column :items, :checklist_id, :integer
    add_index :items, :checklist_id
  end
end
