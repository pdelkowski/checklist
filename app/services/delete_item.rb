class DeleteItem < Service
  attribute :item, Item

  # @param item Template
  def initialize(item)
    super(item: item)
  end

  def call
    item.destroy!
  end
end