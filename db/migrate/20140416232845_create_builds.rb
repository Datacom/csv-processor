class CreateBuilds < ActiveRecord::Migration
  def change
    create_table :builds do |t|
      t.string     :name
      t.references :output_file, index: true
      t.timestamps
    end
  end
end
