class CreateChecklist < Service
  attribute :form, Checklist::CreateForm

  # @param form Checklist::CreateForm
  def initialize(form)
    super(form: form)
  end

  def call
    form.validate!

    attributes = form.attributes
    template_id = attributes.delete(:from_template)

    checklist = Checklist.new(attributes)
    checklist.items = get_items_from_template(template_id) unless template_id.nil?
    checklist.save!
    checklist
  end
  
  private
  
    def get_items_from_template(id)
      TemplateItem.where(template_id: id).collect do |item|
        Item.new(description: item.name)
      end
    end
end