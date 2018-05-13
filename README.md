# ISeq Builder

Building ISeq programmably.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'iseq_builder'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install iseq_builder

## Usage

There is brainfxck compiler example in `examples` directory.

    $ cd examples
    $ bundle

compiling brainfxck source code to ISeq binary

    $ bundle exec ruby brainfxck.rb -c -o helloworld.bin bf/helloworld.bf

executing ISeq binary

    $ bundle exec ruby brainfxck.rb -e helloworld.bin


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/youchan/iseq_builder.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
