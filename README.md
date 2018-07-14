# find_binary

Simple library that helps to find path to a executable.

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  find_binary:
    github: DmitryBochkarev/find_binary-crystal
```

## Usage

```crystal
require "find_binary"

crystal = FindBinary.find("crystal")
if crystal.nil?
  puts "crystal not found"
else
  puts "crystal found: #{crystal}"
  puts `#{crystal} -v`
end
```

### Custom paths

You can provide an additional paths for the search.

```crystal
build_in_binary = File.join(Dir.current, "vendor/ag")
find_the_silver_searcher = FindBinary.new("ag")
find_the_silver_searcher.append_path(build_in_binary)
silver_searcher = find_the_silver_searcher.find

puts "ag found: #{silver_searcher}"
puts `#{silver_searcher.not_nil!} --version`
```

## Contributing

1. Fork it (<https://github.com/DmitryBochkarev/find_binary-crystal/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Dmitry Bochkarev](https://github.com/DmitryBochkarev) - creator, maintainer
