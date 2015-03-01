class Api::V1::ItemsController < ApplicationController
  before_action :set_checklist, only: [:index, :create]
  before_action :set_item, only: [:update, :destroy, :complete, :uncomplete]

  def index
    @items = Item.where(checklist: @checklist)
  end

  def create
    @item = Item.new(item_params)
    @item.checklist = @checklist
    if @item.valid? && @item.save
      render :show, status: 201
    else
      render json: validation_error(@item.errors), status: 422
    end
  end

  def update
    if @item.update(item_params)
      render :show
    else
      render json: validation_error(@item.errors), status: 422
    end
  end

  def complete
    unless @item.completed?
      @item.completed_at = Time.now
      @item.save
    end
    render :show
  end

  def destroy
    @item.destroy
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