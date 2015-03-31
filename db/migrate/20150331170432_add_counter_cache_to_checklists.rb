class AddCounterCacheToChecklists < ActiveRecord::Migration
  def up
    add_column :checklists, :items_count, :integer, null: false, default: 0
    
    Checklist.all.each do |c|
      Checklist.update_counters c.id, items_count: c.items.count
    end
  end
  
  def down
    remove_column :checklists, :items_count
  end
end
