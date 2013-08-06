module Zipmark
  class Error < StandardError
    attr_accessor :status

    def initialize(error)
      self.status = error.delete(:status)
      super(error)
    end

    def not_found?
      status == 404
    end
  end
end
