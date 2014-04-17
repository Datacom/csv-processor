class CreateBuildFiles < ActiveRecord::Migration
  def change
    create_table :build_files do |t|
      t.references :build,    index: true
      t.references :rule_set, index: true
      t.string  :path
      t.integer :size
      t.string  :md5

      t.timestamps
    end
  end
end
