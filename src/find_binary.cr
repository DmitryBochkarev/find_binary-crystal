require "./find_binary/*"

class FindBinary
  PATH_SEPARATOR = ':'

  @bin : String
  @paths : Array(String)

  def self.find(bin : String) : String?
    new(bin).find
  end

  def initialize(@bin, paths : Array(String)? = nil)
    if paths
      @paths = paths
    else
      @paths = ENV["PATH"].split(PATH_SEPARATOR)
    end
  end

  def find
    @paths.each do |path|
      full_path = File.join(path, @bin)
      exe = Dir.glob(full_path).find { |f| File.executable?(f) }
      return exe if exe
    end

    nil
  end

  def append_path(*paths)
    @paths.push *paths
  end

  def prepend_path(*paths)
    @paths.unshift *paths
  end
end
