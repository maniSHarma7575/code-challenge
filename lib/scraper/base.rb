module Scraper
  class Base
    def initialize(source)
      @source = source
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
  end
end
