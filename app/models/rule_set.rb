class RuleSet < ActiveRecord::Base
  has_many :field_mappings
  has_many :build_files

  def to_hash
    Hash[field_mappings.map { |f| [f.src_field_name, f.out_field_name] }]
  end
end
