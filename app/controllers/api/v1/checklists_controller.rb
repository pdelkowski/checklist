class Api::V1::ChecklistsController < ApplicationController
  def create
    @checklist = Checklist.new(new_checklist_params)
    if @checklist.valid?
      render :show
    else
      render json: validation_error(@checklist.errors), status: 422
    end
  end

  private

  def new_checklist_params
    params.permit(:name)
  end
end
