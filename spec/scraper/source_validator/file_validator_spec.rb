require 'rspec'
require_relative '../../../lib/scraper/source_validator/file_validator'

RSpec.describe Scraper::SourceValidator::FileValidator do
  describe '#valid?' do
    context 'when the source is a valid HTML file path' do
      let(:valid_file_path) { 'assets/files/van-gogh-paintings.html' }

      before do
        allow(File).to receive(:exist?).with(valid_file_path).and_return(true)
        allow(File).to receive(:extname).with(valid_file_path).and_return('.html')
      end

      it 'returns true' do
        validator = described_class.new(valid_file_path)
        expect(validator.valid?).to eq(true)
      end
    end

    context 'when the source file does not exist' do
      let(:invalid_file_path) { 'nonexistent_file.html' }

      before do
        allow(File).to receive(:exist?).with(invalid_file_path).and_return(false)
      end

      it 'returns false' do
        validator = described_class.new(invalid_file_path)
        expect(validator.valid?).to eq(false)
      end
    end

    context 'when the source file is not an HTML file' do
      let(:non_html_file_path) { 'assets/files/van-gogh-paintings.json' }

      before do
        allow(File).to receive(:exist?).with(non_html_file_path).and_return(true)
        allow(File).to receive(:extname).with(non_html_file_path).and_return('.json')
      end

      it 'returns false' do
        validator = described_class.new(non_html_file_path)
        expect(validator.valid?).to eq(false)
      end
    end
  end
end
