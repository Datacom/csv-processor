class Build < ActiveRecord::Base
  has_many :input_files, -> { where(output: false).order(:position) }, class_name: 'BuildFile'
  has_one  :output_file, -> { where output: true },                    class_name: 'BuildFile'

  accepts_nested_attributes_for :input_files, allow_destroy: true

  validate :file_positions_present_and_unique

  after_save :save_output_file

  def table
    # Memoized
    return @table if @table

    files = input_files.reject(&:marked_for_destruction?).sort_by(&:position) # changes won't have been saved in preview

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
    file = output_file || build_output_file
    file.table = table
    file.filename = [
      id,
      name.downcase.split(/\W/).compact.join('_'),
      Time.now.iso8601.split(/\D/).compact.join('_')
    ].join('-') + '.csv'
  end

  private

  def file_positions_present_and_unique
    poses = input_files.map &:position
    errors.add(:base, "Input file positions are required") unless poses.all?
    errors.add(:base, "Input file positions must be unique") if poses != poses.uniq
  end

  def save_output_file
    output_file.try :save
  end
end
