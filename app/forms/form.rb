class Form
  include Virtus.model
  include ActiveModel::Validations

  def validate!
    valid? || raise(Error.validation_failed(self.errors))
  end
end