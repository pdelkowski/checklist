class DefaultController < ApplicationController
  def homepage
    @items = Item.where(completed_at: nil)
  end
end
