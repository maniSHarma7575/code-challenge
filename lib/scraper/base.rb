require 'json'
require_relative 'source_validator/validators'

module Scraper
  class Base
    def initialize(source)
      @source = source
      @validator = select_validator(source)
      unless @validator.valid?
        raise ArgumentError, "Invalid #{source_type.to_s.capitalize}: #{@source}"
      end
    end

    def scrape
      raise NotImplementedError, "Subclasses must implement the scrape method"
    end

    def parser
      raise NotImplementedError, "Subclasses must implement the parser method"
    end

    def read_html
      raise NotImplementedError, "Subclasses must implement the read_html method"
    end

    def output_file_name
      raise NotImplementedError, "Subclasses must implement the output_file_name method"
    end

    def source_type
      raise NotImplementedError, "Subclasses must implement the source_type method"
    end

    def generate_file(content)
      setup_output_directory
      File.write("#{output_directory_path}/#{output_file_name}", content)
    end

    def generate_json
      content = JSON.pretty_generate(scrape)
      generate_file(content)
    end

    private
    
    def setup_output_directory
      FileUtils.mkdir_p(output_directory_path)
    end

    def output_directory_path
      "assets/public"
    end

    def select_validator(source)
      validator_class = SourceValidator::VALIDATORS[source_type]
      raise ArgumentError, "Unsupported source type: #{source}" unless validator_class

      validator_class.new(source)
    end
  end
end
