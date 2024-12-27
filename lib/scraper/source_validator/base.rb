module Scraper
  module SourceValidator
    class Base
      def initialize(source)
        @source = source
      end

      def valid?
        raise NotImplementedError, "Subclasses must implement the parser method"
      end
    end
  end
end
