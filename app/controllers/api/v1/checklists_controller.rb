class Api::V1::ChecklistsController < ApplicationController
  before_action :set_checklist, only: [:show, :update, :destroy]

  def index
    @checklists = Checklist.order(created_at: 'DESC')
  end

  def show
  end

  def create
    form = ChecklistForm.new(checklist_params)
    @checklist = CreateChecklist.call(form)

    render :show
  end

  def update
    form = ChecklistForm.new(checklist_params)
    @checklist = UpdateChecklist.call(@checklist, form)

    render :show
  end

  def destroy
    DeleteChecklist.new(@checklist)

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
