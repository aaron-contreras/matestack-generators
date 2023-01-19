# MatestackGenerators

This gem was born out of a conflicting personal hybrid of being a lazy developer and wanting to keep standards of code cleanliness and best practices while developing on Matestack-based applications on my day-to-day. I find myself constantly repeating some Matestack workflow while developing a new feature or refactoring some code. To solve this, I've started to leverage one of the beauties of the Ruby on Rails framework: [Generators](https://guides.rubyonrails.org/generators.html) ❤️

## Installation

1. Add to your Matestack Rails app's by copying the following line to your Gemfile

```
gem 'matestack_generators', git: "https://github.com/aaron-contreras/matestack-generators"
```

2. Run bundle install

```
bundle install
```

## Usage

1. [Component Registry](./lib/generators/matestack/registry/USAGE)
2. [Matestack::Ui::Component](./lib/generators/matestack/component/USAGE)
3. [Matestack::Ui::Page](./lib/generators/matestack/page/USAGE)
4. [Matestack::Ui::Layout](./lib/generators/matestack/layout/USAGE)
5. [Matestack::Ui::VueJsComponent](./lib/generators/matestack/vue_js_component/USAGE)
and more to come...

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/matestack_generators. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/matestack_generators/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the MatestackGenerators project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/matestack_generators/blob/main/CODE_OF_CONDUCT.md).
