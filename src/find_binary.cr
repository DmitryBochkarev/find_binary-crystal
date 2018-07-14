require "./find_binary/*"

# `FindBinary` finds a binary in a system path or a path provided.
#
# Find crystal binary in a system path.
# ```
# FindBinary.find("crystal") # => /usr/bin/crystal
# ```
#
# Alternatively, you can provide paths in which binary should be
# searched instead of a system path.
# ```
# build_in_binary = File.join(Dir.current, "vendor/ag")
# find_the_silver_searcher = FindBinary.new("ag", [build_in_binary])
# silver_searcher = find_the_silver_searcher.find # => ./vender/ag
# ```
#
# Or, if you vendor a binary, and want to use this as a fallback,
# you can append a vendor path.
# ```
# build_in_binary = File.join(Dir.current, "vendor/ag")
# find_the_silver_searcher = FindBinary.new("ag")
# find_the_silver_searcher.append_path(build_in_binary)
# silver_searcher = find_the_silver_searcher.find # => /usr/bin/ag
# ```
class FindBinary
  private PATH_SEPARATOR = ':'

  @bin : String
  @paths : Array(String)

  # Finds a *bin* in a system path.
  #
  # Using the "PATH" environment variable, to determines where to search.
  # ```
  # FindBinary.find("crystal") # => /usr/bin/crystal
  # ```
  def self.find(bin : String) : String?
    new(bin).find
  end

  # Creates a new finder for the *bin*, allowing to override the search *paths*.
  #
  # ```
  # build_in_binary = File.join(Dir.current, "vendor/ag")
  # find_the_silver_searcher = FindBinary.new("ag", [build_in_binary])
  # ```
  def initialize(@bin, paths : Array(String)? = nil)
    if paths
      @paths = paths
    else
      @paths = ENV["PATH"].split(PATH_SEPARATOR)
    end
  end

  # Find the binary in a search path.
  def find : String?
    @paths.each do |path|
      full_path = File.join(path, @bin)
      exe = Dir.glob(full_path).find { |f| File.executable?(f) }
      return exe if exe
    end

    nil
  end

  # Append *paths* to the end of a search path.
  def append_path(*paths)
    @paths.push *paths
  end

  # Prepend *paths* to the head of a search path.
  def prepend_path(*paths)
    @paths.unshift *paths
  end
end
