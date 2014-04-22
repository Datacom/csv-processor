class RuleSet < ActiveRecord::Base
  has_many :field_mappings
  has_many :build_files

  # Returns a hash of the field mappings (src => out), with a default value of <src>.
  def to_hash
    hash = Hash.new { |_, k| k }
    field_mappings.each { |f| hash[f.src_field_name] = f.out_field_name }
    hash
  end
end
