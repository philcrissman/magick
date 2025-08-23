# maths

module Magick
  module Maths
    class << self
      # for addition, we'll just use Ruby
      def add = ->(x){ ->(y) { x + y }}

      def negate = ->(x) { -x }

      def subtract = ->(x){ ->(y) { add.(x).(negate.(y)) }}

      def multiply
        power.(add)
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

      def div_to_f
        ->(n){
          ->(d){
            # in order to get a float, we'll just
            # use Ruby's `/` operator, and make sure
            # at least one argument is cast to float.
            n / d.to_f
          }
        }
      end

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
        power.(multiply)
      end

      def power
        # power needs a base, an exponent, and an
        # operation. Powers of addition is equivalent
        # to multiplication; powers of multiplication
        # is equivalent to exponentiation
        ->(op) { 
          ->(base) {
            ->(exponent) {
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

      def average
        Smullyan::Birds::Phi.
          (Magick::Maths::div_to_f).
          (Magick::Loops::sum).
          (Magick::Loops::length)
      end

      def powers_of_two = power.(multiply).(2)

      # x and y are pairs of ints
      def fibonacci_matrix_multiply = ->(x){
        ->(y){
          [x[0] * (y[1] + y[0]) + x[1] * y[0], x[0] * y[0] + x[1] * y[1]]
        }
      }

      def fibonacci
        ->(n){
          n == 0 ? 0 :
          power.(fibonacci_matrix_multiply).([1,0]).(n)[0]
        }
      end
    end
  end
end
