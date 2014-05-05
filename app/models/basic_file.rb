class BasicFile < ActiveRecord::Base
  class ReadOnlyError < IOError; end
  class FileChangedError < IOError; end

  REPO = File.join("tmp", "files")

  before_save :write, if: :content_present?

  validates :path, presence: true

  def content
    @content ||= read_and_validate
  end

  def content=(new_content)
    raise ReadOnlyError, "Can't write to an original build file" if role == BuildFile::INPUT && content_present?
    @content = new_content
  end

  def content_present?
    @content.present?
  end

  def file=(upload)
    case upload
    when ActionDispatch::Http::UploadedFile
      self.filename = upload.original_filename
      self.content  = upload.read.encode
    when File
      self.filename = File.split(upload.path)[1]
      self.content  = upload.read.encode
    when String
      self.filename = File.split(upload)[1]
      self.content  = File.read(upload).encode
    end
  end

  def filename
    File.split(path)[1]
  end

  def filename=(filename)
    self.path = File.join(REPO, filename)
  end

  private

  def read_and_validate
    tmp = File.read(path)
    raise FileChangedError, "File has been changed externally" if Digest::MD5.hexdigest(tmp) != md5
    tmp
  end

  def write
    Dir.mkpath REPO
    self.size = File.write(path, @content)
    self.md5 = Digest::MD5.file(path).hexdigest
  end
end
