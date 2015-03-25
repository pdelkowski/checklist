class UpdateTemplate < Service
  attribute :template, Template
  attribute :form, TemplateForm

  # @param template Template
  # @param form TemplateForm
  def initialize(template, form)
    super(form: form, template: template)
  end

  def call
    form.validate!

    template.update!(form.attributes)
    template
  end
end