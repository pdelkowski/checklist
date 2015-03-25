class CreateChecklist < Service
  attribute :form, ChecklistForm

  # @param form ChecklistForm
  def initialize(form)
    super(form: form)
  end

  def call
    form.validate!

    checklist = Checklist.new(form.attributes)
    checklist.save!
    checklist
  end
end