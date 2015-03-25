class Service
  include Virtus.model

  def self.call(*args)
    new(*args).call
  end
end