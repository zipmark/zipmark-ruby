class WorkflowProxy
  attr_accessor :client

  def initialize(client)
    self.client = client
  end

  def create(options = {})
    Workflow.new(options.merge(client: client))
  end
end
