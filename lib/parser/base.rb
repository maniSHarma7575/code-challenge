module Parser
  class Base
    def initialize(document)
      @document = document
    end

    def parse
      raise NotImplementedError, "Subclasses must implement the parse method"
    end
  end
end