class Error::UnprocessableEntity
  class ValidationFailed < UnprocessableEntity
    def initialize(errors)
      super('There are some validation errors', :validation_failed)
      @errors = errors
    end
  end
end