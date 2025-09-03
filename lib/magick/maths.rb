# maths

module Magick
  module Maths
    class << self
      # for addition, we'll just use Ruby
      def add = ->(x){ ->(y) { x + y }}

      def negate = ->(x) { -x }

      def subtract = ->(x){ ->(y) { add.(x).(negate.(y)) }}

      def multiply
        power_2.(add)
      end
      alias :mult :multiply

      # See note on `mod`
      def divide
        Smullyan::Birds::Y.(->(f){ 
          ->(n){ 
            ->(d){ 
              n < d ? 0 : 1 + f.(subtract.(n).(d)).(d)
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

      # This implementation of mod _works_ but is mostly 
      # provided as a curiousity: ie, how could we implement 
      # modulus with the Y combinator and repeated subtraction?
      # It isn't efficient, as you will find if you ever try, say,
      # mod.(65536).(2)
      def mod
        Smullyan::Birds::Y.(->(f){
          ->(n){
            ->(d){
              n < d ? n : f.(subtract.(n).(d)).(d)
            }
          }
        })
      end

      def exp
        power_2.(multiply)
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

      # power, as written, will have a stack trace error if we try to 
      # do something like power.(mult).(2).(32)
      # If we eliminate the recursion, we can avoid this, but it means we need
      # to use some regular Ruby constructs (eg, `while`, instead of the Y combinator)
      # The following is essentially how Stepanov & McJones define `power` in 
      # Elements of Programming
      def power_accumulate_positive
        ->(op){
          ->(r){
            ->(a){
              ->(n){
                while (true)
                  if n % 2 != 0
                    r = op.(r).(a)
                    return r if n == 1
                  end
                  a = op.(a).(a)
                  n = div.(n).(2)
                end
              }
            }
          }
        }
      end

      def power_accumulate
        ->(op){
          ->(r){
            ->(n){
              ->(a){
                return r if n == 0
                power_accumulate_positive.(op).(r).(n).(a)
              }
            }
          }
        }
      end

      def power_2
        ->(op){
          ->(b){
            ->(e){
              while (e % 2 == 0)
                b = op.(b).(b)
                e = e/2
              end
              e = e/2
              return b if e == 0
              power_accumulate.(op).(b).(op.(b).(b)).(e)
            }
          }
        }
      end

      # average expects an array
      # eg: average.([1,2,3]) => 2.0
      def average
        Smullyan::Birds::Phi.
          (Magick::Maths::div_to_f).
          (Magick::Loops::sum).
          (Magick::Loops::length)
      end

      def powers_of_two = exp.(2)

      # x and y are pairs of ints
      def fibonacci_matrix_multiply = ->(x){
        ->(y){
          [
            x[0] * (y[1] + y[0]) +
              x[1] * y[0], 
            x[0] * y[0] +
              x[1] * y[1]
          ]
        }
      }

      def fibonacci
        ->(n){
          n == 0 ? 0 :
          power_2.(fibonacci_matrix_multiply).([1,0]).(n)[0]
        }
      end
    end
  end
end
