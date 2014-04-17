class RuleSet < ActiveRecord::Base
  has_many :field_mappings
  has_many :build_files
end
