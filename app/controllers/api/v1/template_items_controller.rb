class Api::V1::TemplateItemsController < ApplicationController
  include Documentation
    
  before_action :set_template, only: [:index, :create]
  before_action :set_item, only: [:show, :update, :destroy]

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
    render :show
  end
  
  def update
    form = TemplateItemForm.new(params)
    @item = UpdateTemplateItem.call(@item, form)
    render :show
  end

  private
  
    def set_item
      @item = TemplateItem.find(params[:id])
    end

    def set_template
      @template = Template.find(params[:template_id])
    end
end