class CreateDb < ActiveRecord::Migration
	def self.up
		create_table :minerals_transactions do |t|
			t.integer :mineral_id
			t.float :buy_price
			t.integer :quantity
			t.float :base_price
			t.float :corp_rise

			t.timestamps
		end
	end

  def self.down
  end
end
