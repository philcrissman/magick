# Magick

This gem is sort of a set of toys. It builds a sort of a set of functions which use lambdas and combinators (from the `smullyan` gem) to do things like arithmetic, map & fold implemented with the Y combinator, and an `average` function implemented with the Phi combinator.

## Installation

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add magick
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install magick
```

## Usage

This is more or less a set of functional toys that attempt to do something actually _useful_ with S-K-I combinators from `smullyan` along with some lambdas and _just enough_ Ruby. I didn't want to go as far as implementing Church numerals, so it's just using numbers from Ruby, as well as the `+` operator and the negation `-` operator; all other math operators (subtract, multiply, divide, etc.) are implemented in terms of `add` and `negate`, and each other. It uses the Y combinator whenever loops or recursion is required.

Using a given function is verbose:

```
avg = Magick::Maths::average.([1, 2, 3])
```

but you could just create a local variable or constant to avoid always needing to type `Magick::[module]`:

```
average = Magick::Maths::average
avg = average.([1,2,3])
```

Keep in mind that all the methods in the modules actually return lambdas, so using them requires `.()` or `.call()`.
```
```
```
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/magick. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/magick/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Magick project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/magick/blob/main/CODE_OF_CONDUCT.md).
