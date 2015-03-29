class CreateItem < Service
  attribute :form, Item::CreateForm

  # @param form Item::CreateForm
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