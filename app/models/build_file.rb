require 'csv'

class BuildFile < ActiveRecord::Base
  belongs_to :build
  belongs_to :rule_set

  attr_accessor :raw

  def file=(upload)
    case upload
    when ActionDispatch::Http::UploadedFile
      self.raw  = upload.read.encode
      self.path = "tmp/files/#{upload.original_filename}"
    when File
      self.raw  = upload.read.encode
      self.path = "tmp/files/#{File.split(upload.path)[1]}"
    when String
      self.raw  = File.read(upload).encode
      self.path = "tmp/files/#{File.split(upload)[1]}"
    end

    Dir.mkpath File.split(path)[0]
    self.size = File.write(path, raw)
    self.md5 = Digest::MD5.file(path).hexdigest
  end

  def to_a
    CSV.parse(raw)
  end
end

class Dir
  # Recursively creates a directory. Unlike #mkdir, #mkpath will do nothing rather than fail if the directory already
  # exists. This makes it act like `mkdir -p` in bash.
  # E.g. <code>Dir.mkpath('path/to/deep/folder')</code>
  def self.mkpath(path, *permissions)
    parent = File.split(path)[0]
    mkpath(parent, *permissions) unless exists?(parent)
    mkdir(path, *permissions) unless exists?(path)
  end
end
