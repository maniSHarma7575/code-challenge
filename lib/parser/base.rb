module Parser
  class Base
    def initialize(document)
      @document = document
    end

    def parse
      raise NotImplementedError, "Subclasses must implement the parse method"
    end

    def parent_element
      raise NotImplementedError, "Subclasses must implement the parent_element method"
    end
  end
end
