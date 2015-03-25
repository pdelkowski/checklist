class Api::V1::TemplatesController < ApplicationController
  before_action :set_template, only: [:show, :update, :destroy]

  def index
    @templates = Template.all

    render :index
  end

  def show
    render :show
  end

  def create
    form = TemplateForm.new(params)
    @template = CreateTemplate.call(form)

    render :show, status: 201
  end

  def update
    form = TemplateForm.new(params)
    @template = UpdateTemplate.call(@template, form)

    render :show
  end

  def destroy
    render :show
  end

  private

    def set_template
      @template = Template.find(params[:id])
    end
end