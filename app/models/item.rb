class Item < ActiveRecord::Base
  belongs_to :checklist, counter_cache: true

  def completed?
    !completed_at.nil?
  end
end
