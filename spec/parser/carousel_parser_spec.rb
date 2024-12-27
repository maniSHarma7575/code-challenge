require 'spec_helper'
require_relative '../../lib/parser/carousel_parser'
require 'nokolexbor'

RSpec.describe Parser::CarouselParser do
  let(:file_content) { '<html><body></body></html>' }
  let(:document) { Nokolexbor::HTML(file_content) }
  let(:carousel_parser) { described_class.new(document) }

  describe '#initialize' do
    it 'initializes with a document' do
      expect { carousel_parser }.not_to raise_error
    end
  end

  describe '#parse' do
    it 'returns a hash with an empty artworks array' do
      expected_result = { artworks: [] }
      expect(carousel_parser.parse).to eq(expected_result)
    end
  end
end
