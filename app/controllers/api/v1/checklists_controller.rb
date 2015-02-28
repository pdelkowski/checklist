class Api::V1::ChecklistsController < ApplicationController
  def create
    @checklist = Checklist.new(checklist_params)
    if @checklist.valid? && @checklist.save
      render :show
    else
      render json: validation_error(@checklist.errors), status: 422
    end
  end

  def update
    @checklist = Checklist.find(params[:id])
    if @checklist.update(checklist_params)
      render :show
    else
      render json: validation_error(@checklist.errors), status: 422
    end
  end

  def destroy
  end

  private

  def checklist_params
    params.permit(:name)
  end
end
