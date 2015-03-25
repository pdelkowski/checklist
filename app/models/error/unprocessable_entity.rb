class Error::UnprocessableEntity < Error
  def initialize(message = 'Unprocessable entity', key = :unprocessable_entity)
    super(message, key, 422)
  end
end