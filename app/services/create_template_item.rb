class CreateTemplateItem < Service
  attribute :form, TemplateItemForm

  # @param form TemplateItemForm
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
