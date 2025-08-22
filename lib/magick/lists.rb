module Magick
  module Lists
    class << self
      def car = ->(list){ list.first }

      def cdr = ->(list){ list.drop(1) }

      def cons = ->(el){ ->(list) { [el] + list }}

      def is_empty = ->(list) { list.empty? }
    end
  end
end
