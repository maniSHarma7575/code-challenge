module Parser
  class CarouselItemParser
    GOOGLE_URL = 'https://www.google.com'.freeze

    def initialize(item, images)
      @item = item
      @images = images
    end

    def parse
      content = {
        name: name,
        link: link,
        image: image,
      }

      content.merge!(extensions: extensions) unless extensions.empty?
      content
    end

    private
    
    def name
      @item.at_css('div.pgNMRc').text
    end

    def link
      GOOGLE_URL + @item.at_css('a').attr('href')
    end

    def image
      image_element = @item.at_css('img.taFZJe')
      id = image_element.attr('id')

      image = @images.find { |image| image[:id] == id } if id
      return image[:image] if image

      image_element.attr('data-src') || image_element.attr('src')
    end

    def extensions
      extension = @item.at_css('div.cxzHyb')
      return [extension.text] if extension && !extension.text&.empty?

      []
    end
  end
end
