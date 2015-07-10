class DisplayProxy
  attr_accessor :client

  def initialize(client)
    self.client = client
  end

  def create(options = {})
    Display.new(options.merge(client: client))
  end
end
