class Build < ActiveRecord::Base
  OUTPUT = 'BUILD_OUTPUT'

  has_many :build_files, -> { order(:position) }
  belongs_to :output_file, class_name: 'BasicFile'

  accepts_nested_attributes_for :build_files, allow_destroy: true

  validate :file_positions_present_and_unique

  after_save :save_output_file

  def table
    # Memoized
    return @table if @table

    files = build_files

    # Grab all the headers
    headers = files.map(&:headers).flatten.uniq

    # Set up a table
    table = CSV::Table.new []

    # Add a blank row for each record in the files (CSV::Table#[]= removes records that don't fit into the existing columns)
    files.each { |file| file.table.each { table << [] } }

    # Populate
    headers.each do |column|
      table[column] = files.map { |file| file.table[column] }.flatten
    end

    # Memoize
    @table = table
  end

  def update_output_file
    self.output_file   ||= build_output_file
    output_file.role     = OUTPUT
    output_file.content  = table.to_s
    output_file.filename = [
      id,
      name.downcase.split(/\W/).compact.join('_'),
      Time.now.iso8601.split(/\D/).compact.join('_')
    ].join('-') + '.csv'
  end

  private

  def file_positions_present_and_unique
    poses = build_files.map &:position
    errors.add(:base, "Input file positions are required") unless poses.all?
    errors.add(:base, "Input file positions must be unique") if poses != poses.uniq
  end

  def save_output_file
    output_file.try :save
  end
end
