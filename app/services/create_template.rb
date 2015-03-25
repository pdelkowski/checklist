class CreateTemplate < Service
  attribute :form, TemplateForm

  def initialize(form)
    super(form: form)
  end

  def call
    form.validate!

    template = Template.new(form.attributes)
    template.save!
    template
  end
end