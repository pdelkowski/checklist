class ItemsController < ApplicationController
  def index
    @items = Item.where(completed_at: nil)
  end
end
