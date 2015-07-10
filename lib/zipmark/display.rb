class Display
  attr_accessor :client, :data, :name

  def initialize(options = {})
    self.client = options[:client]
    self.data = options[:data]
    self.name = options[:name]
  end

  def token
    JWT.encode(
      {
        display: name,
        application_id: client.adapter.username,
        iat:     Time.now.to_i,
        data:    data
      },
      client.adapter.password
    )
  end
end
