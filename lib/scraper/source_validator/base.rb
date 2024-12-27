module Scraper
  module SourceValidator
    class Base
      def initialize(source)
        @source = source
      end

      def valid?
        raise NotImplementedError, "Subclasses must implement the valid? method"
      end
    end
  end
end
