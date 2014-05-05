class CreateBuildFiles < ActiveRecord::Migration
  def change
    create_table :build_files do |t|
      t.references :build,       index: true
      t.integer    :position
      t.references :rule_set,    index: true
      t.references :input_file,  index: true
      t.references :output_file, index: true

      t.timestamps
    end
  end
end
