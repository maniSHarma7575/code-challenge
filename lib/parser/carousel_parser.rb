require_relative 'base'

module Parser
  class CarouselParser < Base
    def initialize(document)
      super(document)
    end

    def parse
      { artworks: [] } #Artwork parsed content will come here
    end
  end
end