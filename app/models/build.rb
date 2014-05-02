class Build < ActiveRecord::Base
  has_many :build_files, -> { order :position }

  accepts_nested_attributes_for :build_files, allow_destroy: true

  validate :file_positions_unique

  def table
    # Memoized
    return @table if @table

    files = build_files.reject(&:marked_for_destruction?).sort_by(&:position) # changes won't have been saved in preview

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

  private

  def file_positions_unique
    poses = build_files.map &:position
    errors.add(:base, "Build file positions must be unique") if poses != poses.uniq
  end
end
