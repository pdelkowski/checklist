class Item < ActiveRecord::Base
  def complete
    self.completed_at = Time.now
    save
  end
end
