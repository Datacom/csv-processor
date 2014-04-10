class CreateFieldMappings < ActiveRecord::Migration
  def change
    create_table :field_mappings do |t|
      t.string :src_field_name
      t.string :out_field_name

      t.timestamps
    end
  end
end
