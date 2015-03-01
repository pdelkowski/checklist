class ItemsController < ApplicationController
  before_action :set_item, only: [:complete, :uncomplete]

  def index
    @items = Item.order(:created_at)
  end

  def complete

    @item.completed_at = Time.now
    @item.save

    render :show
  end

  def uncomplete
    @item.completed_at = nil
    @item.save

    render :show
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end
end
