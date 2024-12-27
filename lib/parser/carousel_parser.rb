require_relative 'base'
require_relative 'carousel_item_parser'
require_relative 'carousel_image_parser'

module Parser
  class CarouselParser < Base
    def initialize(document)
      super(document)
    end

    def parse
      content = parent_element.map do |element|
        CarouselItemParser.new(element, carousel_images).parse
      end

      { artworks: content }
    end

    def parent_element
      @document.css('div.iELo6')
    end

    def carousel_images
      @images ||= CarouselImageParser.new(@document).parse
    end
  end
end

