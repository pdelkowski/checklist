class Api::V1::ItemsController < ApplicationController
  before_action :set_checklist, only: [:index, :create]

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

  private

    def item_params
      params.permit(:description)
    end

    def set_checklist
      @checklist = Checklist.find(params[:checklist_id])
    end
end