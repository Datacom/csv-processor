class CreateBuildFiles < ActiveRecord::Migration
  def change
    create_table :build_files do |t|
      t.references :build,                 index: true
      t.integer    :position, null: false
      t.references :rule_set, null: false, index: true
      t.string     :path
      t.integer    :size
      t.string     :md5

      t.timestamps
    end

    add_index :build_files, [:build_id, :position], unique: true
  end
end
