require 'csv'

class BuildFile < ActiveRecord::Base
  belongs_to :build
  belongs_to :rule_set

  before_save :save_raw_file

  REPO = File.join("tmp", "files")

  # Only load the contents when required. Set @raw to nil to reload.
  def raw
    @raw ||= File.read(path)
  end

  def file=(upload)
    case upload
    when ActionDispatch::Http::UploadedFile
      self.path = File.join(REPO, upload.original_filename)
      @raw      = upload.read.encode
    when File
      self.path = File.join(REPO, File.split(upload.path)[1])
      @raw      = upload.read.encode
    when String
      self.path = File.join(REPO, File.split(upload)[1])
      @raw      = File.read(upload).encode
    end
  end

  def to_a
    raw ? CSV.parse(raw) : [[]]
  end

  def translate!
    input  = to_a
    output = [input[0].map { |h| rule_set.to_hash[h] || h }] + input[1..-1]
    @raw   = output.map(&:to_csv).join
  end

  def raw_changed?
    Digest::MD5.hexdigest(raw) != md5
  end

  private

  def save_raw_file
    Dir.mkpath REPO
    self.size = File.write(path, raw)
    self.md5 = Digest::MD5.file(path).hexdigest
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
