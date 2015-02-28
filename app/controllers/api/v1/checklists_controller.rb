class Api::V1::ChecklistsController < ApplicationController
  before_action :set_checklist, only: [:show, :update, :destroy]

  def index
    @checklists = Checklist.all
  end

  def show
  end

  def create
    @checklist = Checklist.new(checklist_params)
    if @checklist.valid? && @checklist.save
      render :show
    else
      render json: validation_error(@checklist.errors), status: 422
    end
  end

  def update
    if @checklist.update(checklist_params)
      render :show
    else
      render json: validation_error(@checklist.errors), status: 422
    end
  end

  def destroy
    @checklist.destroy
    render :show
  end

  private

  def set_checklist
    @checklist = Checklist.find(params[:id])
  end

  def checklist_params
    params.permit(:name)
  end
end
