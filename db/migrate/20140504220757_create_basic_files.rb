class CreateBasicFiles < ActiveRecord::Migration
  def change
    create_table :basic_files do |t|
      t.string  :path, null: false
      t.integer :size
      t.string  :md5
      t.string  :role

      t.timestamps
    end

    add_index :basic_files, :path, unique: true
  end
end
