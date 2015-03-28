class UpdateTemplateItem < Service
  attribute :item, TemplateItem
  attribute :form, TemplateItemForm

  # @param item TemplateItem
  # @param form TemplateItemForm
  def initialize(item, form)
    super(form: form, item: item)
  end

  def call
    form.validate!

    item.update!(form.attributes)
    item
  end
end