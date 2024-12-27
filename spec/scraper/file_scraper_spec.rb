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
      content = '{}'

      expect(File).to receive(:write).with(file_path, content)
      file_scraper.generate_file(content)
    end
  end

  describe '#generate_json' do
    it 'calls #generate_file with JSON content' do
      content = '{}'

      expect(file_scraper).to receive(:generate_file).with(content)
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
end