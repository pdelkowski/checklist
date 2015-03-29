class UpdateTemplateItem < Service
  attribute :item, TemplateItem
  attribute :form, TemplateItem::UpdateForm

  # @param item TemplateItem
  # @param form TemplateItem::UpdateForm
  def initialize(item, form)
    super(form: form, item: item)
  end

  def call
    form.validate!

    item.update!(form.attributes)
    item
  end
end