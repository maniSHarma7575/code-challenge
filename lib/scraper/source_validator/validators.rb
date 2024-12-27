require_relative 'file_validator'

module Scraper
  module SourceValidator
    VALIDATORS = {
      file: FileValidator
    }.freeze
  end
end