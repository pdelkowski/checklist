class Api::V1::ItemsController < ApplicationController
  include Documentation
  
  before_action :set_checklist, only: [:index, :create]
  before_action :set_item, only: [:update, :destroy, :complete, :uncomplete]

  def index
    @items = Item.where(checklist: @checklist).order(created_at: 'DESC')

    render :index
  end

  def create
    form = ItemForm.new(item_params)
    @item = CreateItem.call(form)

    render :show, status: 201
  end

  def update
    form = ItemForm.new(item_params)
    @item = UpdateItem.call(@item, form)

    render :show
  end

  def complete
    unless @item.completed?
      @item.completed_at = Time.now
      @item.save
    end
    render :show
  end

  def uncomplete
    if @item.completed?
      @item.completed_at = nil
      @item.save
    end
    render :show
  end

  def destroy
    DeleteItem.call(@item)

    render :show
  end

  private

    def item_params
      params.permit(:description)
    end

    def set_checklist
      @checklist = Checklist.find(params[:checklist_id])
    end

    def set_item
      @item = Item.find(params[:id])
    end
end