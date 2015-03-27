class Api::V1::TemplateItemsController < ApplicationController
  before_action :set_template

  def index
    p TemplateItem.all
    @items = @template.template_items

    render :index
  end

  private

    def set_template
      @template = Template.find(params[:template_id])
    end
end