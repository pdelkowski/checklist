class DeleteChecklist < Service
  attribute :checklist, Template

  # @param checklist Checklist
  def initialize(checklist)
    super(checklist: checklist)
  end

  def call
    checklist.destroy!
  end
end