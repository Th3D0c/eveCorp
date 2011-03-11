class CreateMineralsTransactions < ActiveRecord::Migration
  def self.up
    create_table :minerals_transactions do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :minerals_transactions
  end
end
