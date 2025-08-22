# maths

# for addition, we'll just use Ruby
module Magick
  module Maths
    class << self
      def add = ->(x){ ->(y) { x + y }}

      def negate = ->(x) { -x }

      def subtract = ->(x){ ->(y) { add.(x).(negate.(y)) }}

      def multiply
        ->(a){
          ->(b){
            power.(a).(b).(add)
          }
        }
      end
      alias :mult :multiply

      def divide
        Smullyan::Birds::Y.(->(f){ 
          ->(n){ 
            ->(d){ 
              n < d ? 0 : 1 + f.(n - d).(d)
            }
          }
        })
      end
      alias :div :divide

      def mod
        Smullyan::Birds::Y.(->(f){
          ->(n){
            ->(d){
              n < d ? n : f.(n - d).(d)
            }
          }
        })
      end

      def exp
        ->(a){
          ->(b){
            power.(a).(b).(multiply)
          }
        }
      end

      def power
        # power needs a base, an exponent, and an
        # operation. Powers of addition is equivalent
        # to multiplication; powers of multiplication
        # is equivalent to exponentiation
        ->(base) { 
          ->(exponent) {
            ->(op) {
              Smullyan::Birds::Y.(->(f) {
                ->(b) {
                  ->(e) {
                    e == 1 ? b :
                    mod.(e).(2) == 0 ? f.(op.(b).(b)).(divide.(e).(2)) :
                    op.(f.(op.(b).(b)).(divide.(e).(2))).(b)
                  }
                }
              }).(base).(exponent)
            }
          }
        }
      end
    end
  end
end
