require 'spec_helper'
require_relative '../../lib/parser/carousel_image_parser'
require 'nokolexbor'
require 'json'

RSpec.describe Parser::CarouselImageParser do
  let(:file_path) { 'assets/files/van-gogh-paintings.html' }
  let(:file_content) { File.read(file_path) }
  let(:document) { Nokolexbor::HTML(file_content) }
  let(:carousel_image_parser) { described_class.new(document) }

  describe '#initialize' do
    it 'initializes with a document' do
      expect { carousel_image_parser }.not_to raise_error
    end
  end

  describe '#parse' do
    let(:data) { carousel_image_parser.parse }

    it 'returns an array of image data hashes' do
      expect(data).to be_a(Array)
      expect(data).to all(be_a(Hash))
      expect(data).to all(include(:id, :image))
    end
  end

  describe '#parent_element' do
    it 'returns the parent element containing script tags' do
      parent_element = carousel_image_parser.parent_element
      expect(parent_element).to be_a(Nokolexbor::NodeSet)
      expect(parent_element.all? { |node| node.name == 'script' }).to be true
    end
  end
end
