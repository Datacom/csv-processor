class CreateRuleSets < ActiveRecord::Migration
  def change
    create_table :rule_sets do |t|
      t.string :name

      t.timestamps
    end
  end
end
