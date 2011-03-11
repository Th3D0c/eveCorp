class MineralsTransaction < ActiveRecord::Base

	def getLastMineralsPrice
		return Minerals_transaction.group('updated_at', 'mineral_id').order('updated_at DESC').limit(7)
	end
end
