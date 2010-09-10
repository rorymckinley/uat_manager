class CreateAcceptanceTests < ActiveRecord::Migration
  def self.up
    create_table :acceptance_tests do |t|
      t.column :name, :string
      t.column :context,  :string
      t.column :starting_point, :string
      t.timestamps
    end
  end

  def self.down
    drop_table :acceptance_tests
  end
end
