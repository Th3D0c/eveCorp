class MineralsController < ApplicationController
  def index

		@minerals_id_index= {
			11399 => 'Morphite',
			34 => 'Tritanium',
			35 => 'Pyerite',
			36 => 'Mexallon',
			37 => 'Isogen',
			38 => 'Nocxium',
			39 => 'Zydrine',
			40 => 'Megacyte'
		}

		mineral_save = Minerals_transaction.new()
		@prices = mineral_save.getLastMineralsPrice()
  end

end
