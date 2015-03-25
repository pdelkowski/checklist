class Error::ResourceNotFound < Error
  def initialize(message = 'This resource has not been found', key = :resource_not_found)
    super(message, key, 404)
  end
end