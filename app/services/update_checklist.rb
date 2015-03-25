class UpdateChecklist < Service
  attribute :checklist, Checklist
  attribute :form, ChecklistForm

  # @param template Checklist
  # @param form ChecklistForm
  def initialize(checklist, form)
    super(form: form, checklist: checklist)
  end

  def call
    form.validate!

    checklist.update!(form.attributes)
    checklist
  end
end