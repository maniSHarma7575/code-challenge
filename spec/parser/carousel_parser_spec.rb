require 'spec_helper'
require_relative '../../lib/parser/carousel_parser'
require 'nokolexbor'
require 'json'

RSpec.describe Parser::CarouselParser do
  let(:file_path) { 'assets/files/van-gogh-paintings.html' }
  let(:file_content) { File.read(file_path) }
  let(:document) { Nokolexbor::HTML(file_content) }
  let(:carousel_parser) { described_class.new(document) }

  describe '#initialize' do
    it 'initializes with a document' do
      expect { carousel_parser }.not_to raise_error
    end
  end

  describe '#parse' do
    let(:data) { carousel_parser.parse }
    let(:expected_data) { JSON.parse(File.read('assets/files/expected-array.json')) }

    it 'returns a hash containing a non-empty artworks array' do
      expect(data).to be_a(Hash)
      expect(data).to include(:artworks)
      expect(data[:artworks]).to be_a(Array)
      expect(data[:artworks].length).to be > 0
    end

    it 'extracts expected number of artworks' do
      expect(data[:artworks].length).to eq(expected_data['artworks'].length)
    end
  end

  describe '#parent_element' do
    it 'returns the parent element' do
      parent_element = carousel_parser.parent_element
      expect(parent_element).to be_a(Nokolexbor::NodeSet)
    end
  end
end
