class Error < StandardError
  attr_reader :key, :http_status, :errors

  def initialize(message, key, http_status)
    super(message)
    @key = key
    @http_status = http_status
  end

  def self.validation_failed(form)
    UnprocessableEntity::ValidationFailed.new(form)
  end
end