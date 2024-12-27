require 'rspec'
require_relative '../../lib/scraper/file_scraper'

RSpec.describe Scraper::FileScraper do
  let(:file_path) { 'assets/files/van-gogh-paintings.html' }
  let(:file_scraper) { described_class.new(file_path) }

  describe '#output_file_name' do
    it 'returns the correct output file name' do
      expect(file_scraper.output_file_name).to eq("#{File.basename(file_path)}.output.json")
    end
  end

  describe '#generate_file' do
    it 'writes the content to the specified file path' do
      file_path = "assets/public/#{file_scraper.output_file_name}"
      content = File.read('assets/files/expected-array.json')

      expect(File).to receive(:write).with(file_path, content)
      file_scraper.generate_file(content)
    end
  end

  describe '#generate_json' do
    it 'calls #generate_file with JSON content' do
      expect(file_scraper).to receive(:generate_file).with(satisfy do |json|
        parsed_content = JSON.parse(json) rescue nil
        parsed_content.is_a?(Hash) && parsed_content.key?('artworks')
      end)
      file_scraper.generate_json
    end
  end

  describe '#read_html' do
    it 'reads and parses the HTML file using Nokolexbor' do
      expect(file_scraper.read_html).to be_a(::Nokolexbor::Document)
    end
  end

  describe '#parser' do
    it 'returns an instance of CarouselParser' do
      expect(file_scraper.parser).to eq(::Parser::CarouselParser)
    end

    it 'memoizes the parser' do
      first_call = file_scraper.parser
      second_call = file_scraper.parser
      expect(first_call).to equal(second_call)
    end
  end

  describe '#scrape' do
    let(:data) { file_scraper.scrape }
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

    it 'artworks array structure' do
      data[:artworks].each do |artwork|
        expect(artwork).to include(:name)
        expect(artwork[:name]).to be_a(String)
        expect(artwork[:name].length).to be > 0
    
        expect(artwork).to include(:link)
        expect(artwork[:link]).to be_a(String)
        expect(artwork[:link].length).to be > 0
    
        expect(artwork).to include(:image)
        expect(artwork[:image]).to be_a(String)
        expect(artwork[:image].length).to be > 0
    
        if artwork.key?(:extensions)
          expect(artwork[:extensions]).to be_a(Array)
        end
      end
    end

    it 'should match the expected data' do
      artworks = data[:artworks]

      expected_data['artworks'].each_with_index do |expected_artwork, index|
        artwork = artworks[index]

        expect(artwork[:name]).to eq(expected_artwork['name'])
        expect(artwork[:link]).to eq(expected_artwork['link'])
        expect(artwork[:image]).to eq(expected_artwork['image'])
        expect(artwork[:extensions]).to eq(expected_artwork['extensions'])
      end
    end
  end
end

