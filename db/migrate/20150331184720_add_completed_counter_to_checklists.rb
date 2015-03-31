class AddCompletedCounterToChecklists < ActiveRecord::Migration
  def up
    add_column :checklists, :completed_count, :integer, null: false, default: 0
    
    Checklist.all.each do |c|
      completed = Item.where(checklist: c).where.not(completed_at: nil).count
      c.update(completed_count: completed)
    end
  end
  
  def down
    remove_column :checklists, :completed_count
  end
end
