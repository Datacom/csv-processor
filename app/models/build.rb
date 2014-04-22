class Build < ActiveRecord::Base
  has_many :build_files

  accepts_nested_attributes_for :build_files

  def table
    # Memoized
    return @table if @table

    # Grab all the headers
    headers = build_files.map(&:headers).flatten.uniq

    # Set up a table
    table = CSV::Table.new []

    # Make space for the records (CSV::Table#[]= removes records that don't fit into the existing columns)
    build_files.each { |file| file.table.each { table << [] } }

    # Add values
    headers.each do |column|
      table[column] = build_files.map { |file| file.table[column] }.flatten
    end

    # Memoize
    @table = table
  end
end
