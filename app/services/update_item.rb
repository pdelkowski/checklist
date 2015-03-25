class UpdateItem < Service
  attribute :item, Item
  attribute :form, ItemForm

  # @param template Item
  # @param form ItemForm
  def initialize(item, form)
    super(form: form, item: item)
  end

  def call
    form.validate!

    item.update!(form.attributes)
    item
  end
end