class Api::V1::ChecklistsController < ApplicationController
  include Documentation

  before_action :set_checklist, only: [:show, :update, :destroy]

  def index
    @checklists = Checklist.order(created_at: 'DESC')

    render :index
  end

  def show
    render :show
  end

  def create
    form = Checklist::CreateForm.new(new_checklist_params)
    @checklist = CreateChecklist.call(form)

    render :show, status: 201
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

  def new_checklist_params
    params.permit(:name, :from_template)
  end

  def checklist_params
    params.permit(:name)
  end
end
