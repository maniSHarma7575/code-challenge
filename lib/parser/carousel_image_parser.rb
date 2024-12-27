require_relative 'base'

module Parser
  class CarouselImageParser < Base
    def initialize(document)
      super(document)
    end

    def parse
      parent_element.map do |script|
        if script.content =~ /_setImagesSrc\((.*?)\);/
          image = script.content.match(/var s='(data:image\/[^']+)';/)
          id = script.content.match(/var ii=\[\s*'(.*?)'\s*\];/)

          {
            id: id[1],
            image: image[1],
          } if image && id
        end
      end.compact
    end

    def parent_element
      @document.css('script')
    end
  end
end

