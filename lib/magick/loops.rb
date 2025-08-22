module Magick
  module Loops
    class << self
      def map
        ->(func) {
          Smullyan::Birds::Y.(->(map_step) { ->(list) {
            Magick::Lists::is_empty.(list) ?
            [] :
            Magick::Lists::cons.
              (func.(Magick::Lists::car.(list))).
              (map_step.(Magick::Lists::cdr.(list)))
          }})
        }
      end

      def fold
        ->(func) {
          ->(initial) {
            Smullyan::Birds::Y.(->(fold_step) { 
              ->(acc) { 
                ->(list) {
                  Magick::Lists::is_empty.(list) ?
                  acc :
                  fold_step.
                    (func.(acc).(Magick::Lists::car.(list))).
                    (Magick::Lists::cdr.(list))
                }
              }
            }).(initial)
          }
        }
      end

      def sum = fold.(Magick::Maths::add).(0)

      def length = fold.(->(acc) { ->(elem) { acc + 1 }}).(0)
    end
  end
end
