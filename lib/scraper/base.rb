require_relative 'source_validator/validators'

module Scraper
  class Base
    def initialize(source)
      @source = source
      @validator = select_validator(source)
      @validator.valid?
    end

    def scrape
      raise NotImplementedError, "Subclasses must implement the scrape method"
    end

    def parser
      raise NotImplementedError, "Subclasses must implement the parser method"
    end

    def read_html
      raise NotImplementedError, "Subclasses must implement the parser method"
    end

    def output_file_name
      raise NotImplementedError, "Subclasses must implement the parser method"
    end

    def generate_file(content)
      setup_output_directory
      File.write("#{output_directory_path}/#{output_file_name}", content)
    end

    def generate_json
      content = '{}' # Parse the content
      generate_file(content)
    end

    private
    
    def setup_output_directory
      FileUtils.mkdir_p(output_directory_path)
    end

    def output_directory_path
      "assets/public"
    end

    def determine_source_type(source)
      return :file if File.file?(source)

      nil
    end

    def select_validator(source)
      validator_class = SourceValidator::VALIDATORS[determine_source_type(source)]
      raise ArgumentError, "Unsupported source type: #{source}" unless validator_class

      validator_class.new(source)
    end
  end
end
