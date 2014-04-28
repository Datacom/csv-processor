require 'csv'

class BuildFile < ActiveRecord::Base
  belongs_to :build
  belongs_to :rule_set

  before_save :save_raw_file

  REPO = File.join("tmp", "files")

  validates :order, presence: true, uniqueness: {scope: :build_id}

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

  def filename
    File.split(path)[1]
  end

  def table
    @table ||= CSV::Table.new(parsed_csv[1..-1].map { |r| CSV::Row.new(parsed_csv[0], r) })
  end

  delegate :headers, to: :table

  def remove_blanks!
    orig   = table.mode
    @table = table.by_col.delete_if { |c| c.flatten.all?(&:nil?) }
    @table = table.by_row.delete_if &:empty?
    @table = table.send("by_#{orig}")
    @raw   = @table.to_s
    self
  end

  def translate!
    @table = CSV::Table.new(parsed_csv[1..-1].map do |r|
      CSV::Row.new(headers.map { |h| rule_set.to_hash[h] }, r)
    end)
    @raw = @table.to_s
    self
  end

  def set_order!
    self.order = ((build.build_files - [self]).map(&:order).max || 0) + 1
  end

  private

  # Only load the contents when required. Set @raw to nil to reload.
  def raw
    @raw ||= File.read(path)
  end

  def parsed_csv
    @parsed_csv ||= (raw ? CSV.parse(raw) : [[]])
  end

  def raw_changed?
    Digest::MD5.hexdigest(raw) != md5
  end

  def save_raw_file
    translate!
    remove_blanks!
    set_order!

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
