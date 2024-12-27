require 'spec_helper'
require_relative '../../lib/parser/carousel_item_parser'
require 'nokolexbor'

RSpec.describe Parser::CarouselItemParser do
  let(:html_content) do
    <<-HTML
      <div class="carousel-item">
        <div class="pgNMRc">Item Name</div>
        <a href="/search?q=item-link"></a>
        <img class="taFZJe" id="image-id-1" data-src="https://example.com/image1.jpg" />
        <div class="cxzHyb">Extension Text</div>
      </div>
    HTML
  end

  let(:images) do
    [
      { id: 'image-id-1', image: 'https://example.com/image1_override.jpg' },
      { id: 'image-id-2', image: 'https://example.com/image2.jpg' }
    ]
  end

  let(:item) { Nokolexbor::HTML(html_content).at_css('.carousel-item') }
  let(:parser) { described_class.new(item, images) }

  describe '#initialize' do
    it 'initializes with an item and images' do
      expect { parser }.not_to raise_error
    end
  end

  describe '#parse' do
    let(:data) { parser.parse }

    it 'returns a hash with the expected keys' do
      expect(data).to include(:name, :link, :image)
    end

    it 'parses the name correctly' do
      expect(data[:name]).to eq('Item Name')
    end

    it 'parses the link correctly' do
      expect(data[:link]).to eq('https://www.google.com/search?q=item-link')
    end

    it 'parses the image using the images array if id matches' do
      expect(data[:image]).to eq('https://example.com/image1_override.jpg')
    end

    it 'parses the image from the element if id is not in the images array' do
      images.clear
      expect(data[:image]).to eq('https://example.com/image1.jpg')
    end

    it 'parses extensions if present' do
      expect(data).to include(:extensions)
      expect(data[:extensions]).to eq(['Extension Text'])
    end
  end
end
