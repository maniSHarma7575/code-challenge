require 'nokolexbor'
require_relative 'base'
require_relative '../parser/carousel_parser'

module Scraper
  class FileScraper < Base
    def initialize(file_path)
      super(file_path)
    end

    def scrape
      parser.new(read_html).parse
    end

    def read_html
      Nokolexbor::HTML(File.read(@source))
    end

    def parser
      @parser ||= ::Parser::CarouselParser
    end

    def output_file_name
      File.basename(@source) + '.output.json'
    end
  end
end
