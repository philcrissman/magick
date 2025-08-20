# maths

# for addition, we'll just use Ruby
module Magick
  module Maths
    class << self
      def add = ->(x){ ->(y) { x + y }}
    end
  end
end
