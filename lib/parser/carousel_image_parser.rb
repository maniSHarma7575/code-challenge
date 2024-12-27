require_relative 'base'

module Parser
  class CarouselImageParser < Base
    def initialize(document)
      super(document)
    end

    def parse
      parent_element.map do |script|
        parse_script(script.content)
      end.compact
    end

    def parent_element
      @document.css('script')
    end

    private

    def decode_image(image_data)
      image_data.gsub(/\\x([0-9a-fA-F]{2})/) do
        [::Regexp.last_match(1)].pack('H*')
      end
    end

    def parse_script(content)
      return unless content =~ /_setImagesSrc\((.*?)\);/
    
      image = content.match(/var s='(data:image\/[^']+)';/)
      id = content.match(/var ii=\[\s*'(.*?)'\s*\];/)
    
      return unless image && id
    
      {
        id: id[1],
        image: decode_image(image[1])
      }
    end
  end
end
