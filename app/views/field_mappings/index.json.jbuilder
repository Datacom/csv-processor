json.array!(@field_mappings) do |field_mapping|
  json.extract! field_mapping, :id, :rule_set_id, :src_field_name, :out_field_name
  json.url field_mapping_url(field_mapping, format: :json)
end
