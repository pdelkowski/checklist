class Item < ActiveRecord::Base
  belongs_to :checklist, counter_cache: true
  
  after_create  :increment_completed_counter_cache, if: :completed?
  after_update  :update_completed_counter_cache, if: :completed_at_changed?
  after_destroy :decrement_completed_counter_cache, if: :completed?

  def completed?
    !completed_at.nil?
  end
  
  private
  
  def update_completed_counter_cache    
    if completed_at.nil?
      decrement_completed_counter_cache
    else
      increment_completed_counter_cache
    end
  end
  
  def increment_completed_counter_cache
    Checklist.increment_counter(:completed_count, self.checklist)
  end
  
  def decrement_completed_counter_cache
    Checklist.decrement_counter(:completed_count, self.checklist)    
  end
end
