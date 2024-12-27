# frozen_string_literal: true

require_relative "lib/scraper/version"

Gem::Specification.new do |spec|
  spec.name = "scraper"
  spec.version = Scraper::VERSION
  spec.authors = ["maniSHarma7575"]
  spec.email = ["hacker.sharma7575@gmail.com"]

  spec.summary = "Scraper is a gem that scrapes the information from the google search carousel."
  spec.description = "Scraper is a gem that scrapes the information from the google search carousel."
  spec.required_ruby_version = ">= 3.2.2"

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[test/ spec/ features/ .git appveyor Gemfile Rakefile .gitignore])
    end
  end
  spec.bindir = "bin"
  spec.executables = spec.files.grep(%r{\Abin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "nokolexbor", "~> 0.5.4"
end
