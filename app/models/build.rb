class Build < ActiveRecord::Base
  has_many :build_files

  accepts_nested_attributes_for :build_files
end
