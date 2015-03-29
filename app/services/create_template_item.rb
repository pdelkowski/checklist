class CreateTemplateItem < Service
  attribute :form, TemplateItem::CreateForm

  # @param form TemplateItem:CreateForm
  def initialize(form)
    super(form: form)
  end
  
  def call
    form.validate!
    
    item = TemplateItem.new(form.attributes)
    item.save!
    item
  end
end
