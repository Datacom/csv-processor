require 'csv'

class BuildFile < ActiveRecord::Base
  INPUT  = 'BUILD_FILE_INPUT'
  OUTPUT = 'BUILD_FILE_OUTPUT'

  belongs_to :build
  belongs_to :rule_set
  belongs_to :input_file,  class_name: 'BasicFile'
  belongs_to :output_file, class_name: 'BasicFile'

  after_initialize :ensure_basic_files

  validates :position, :rule_set_id, presence: true

  delegate :file=, to: :input_file

  def table
    @table ||= CSV::Table.new(parsed_csv[1..-1].map { |r| CSV::Row.new(parsed_csv[0], r) })
  end

  delegate :headers, to: :table

  def translate
    # translate headers
    row_a = parsed_csv[1..-1].map do |r|
      CSV::Row.new(headers.map { |h| rule_set.to_hash[h] }, r)
    end

    # remove blanks
    tmp = CSV::Table.new(row_a).by_col.delete_if { |c| c.flatten.all?(&:nil?) }.by_row.delete_if(&:empty?).send("by_#{orig}")
    
    # pass result to output file
    output_file.content = tmp.to_s
  end

  private

  def parsed_csv
    @parsed_csv ||= (input_file.content ? CSV.parse(input_file.content) : [[]])
  end

  def ensure_basic_files
    input_file     ||= build_input_file
    input_file.role  = INPUT
    output_file    ||= build_output_file
    output_file.role = OUTPUT
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
