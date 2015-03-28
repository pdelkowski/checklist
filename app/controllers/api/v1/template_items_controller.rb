class Api::V1::TemplateItemsController < ApplicationController
  include Documentation
    
  before_action :set_template, only: [:index, :create]

  def index
    @items = @template.template_items
    render :index
  end
  
  def create
    form = TemplateItemForm.new(params)
    form.template_id = @template.id
    @item = CreateTemplateItem.call(form)
    render :show, status: 201
  end
  
  def show
    @item = TemplateItem.find(params[:id])
    render :show
  end

  private

    def set_template
      @template = Template.find(params[:template_id])
    end
end