require_relative 'base'

module Scraper
  module SourceValidator
    class FileValidator < Base
      def initialize(source)
        super(source)
      end

      def valid?
        file_path? && html_file?
      end
  
      private
  
      def file_path?
        File.exist?(@source)
      end
  
      def html_file?
        File.extname(@source).downcase == '.html'
      end
    end
  end
end
