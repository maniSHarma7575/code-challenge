require_relative 'base'

module Scraper
  class FileScraper < Base
    def initialize(file_path)
      super(file_path)
    end

    def output_file_name
      File.basename(@source) + '.output.json'
    end
  end
end
