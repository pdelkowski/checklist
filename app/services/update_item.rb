class UpdateItem < Service
  attribute :item, Item
  attribute :form, Item::UpdateForm

  # @param template Item
  # @param form Item::UpdateForm
  def initialize(item, form)
    super(form: form, item: item)
  end

  def call
    form.validate!

    item.update!(form.attributes)
    item
  end
end