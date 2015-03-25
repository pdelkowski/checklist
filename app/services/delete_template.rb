class CreateTemplate < Service
  attribute :template, Template

  # @param template Template
  def initialize(template)
    super(template: template)
  end

  def call
    template.destroy!
  end
end