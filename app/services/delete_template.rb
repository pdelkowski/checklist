class DeleteTemplate < Service
  attribute :template, Template

  # @param template Template
  def initialize(template)
    super(checklist: template)
  end

  def call
    template.destroy!
  end
end