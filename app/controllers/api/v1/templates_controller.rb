class Api::V1::TemplatesController < ApplicationController
  before_action :set_template, only: [:show, :update, :destroy]

  api!
  def index
    @templates = Template.all

    render :index
  end

  api!
  def show
    render :show
  end

  api!
  def create
    form = TemplateForm.new(params)
    @template = CreateTemplate.call(form)

    render :show, status: 201
  end

  api!
  def update
    form = TemplateForm.new(params)
    @template = UpdateTemplate.call(@template, form)

    render :show
  end

  api!
  def destroy
    render :show
  end

  private

    def set_template
      @template = Template.find(params[:id])
    end
end