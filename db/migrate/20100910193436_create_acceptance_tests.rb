class CreateAcceptanceTests < ActiveRecord::Migration
  def self.up
    create_table :acceptance_tests do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :acceptance_tests
  end
end
