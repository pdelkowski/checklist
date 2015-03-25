class CreateItem < Service
  attribute :form, ItemForm

  # @param form ItemForm
  def initialize(form)
    super(form: form)
  end

  def call
    form.validate!

    item = Item.new(form.attributes)
    item.save!
    item
  end
end