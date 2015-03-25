class Api::V1::TemplatesController < ApplicationController
  def index
    @templates = Template.all
  end

  def show
    @template = Template.find(params[:id])
  end

  def create
    form = TemplateForm.new(params)
    @template = CreateTemplate.call(form)

    render :show, status: 201
  end
end