class MakeOrdersController < ApplicationController

		require 'rexml/document'
		include REXML

		@@minerals = {
			11399 => 'Morphite',
			34 => 'Tritanium',
			35 => 'Pyerite',
			36 => 'Mexallon',
			37 => 'Isogen',
			38 => 'Nocxium',
			39 => 'Zydrine',
			40 => 'Megacyte'
		}
		
		# Zone de sauvegarde du formulaire
		def create			
			if(params['authenticity_token'] != nil)
				@@minerals.each() { |minid, mineral|
					if(minid != 11399)
						mineral_save = MineralsTransaction.new()
						mineral_save.mineral_id = minid
						mineral_save.buy_price = params[mineral.downcase]['final_price']
						mineral_save.base_price = params[mineral.downcase]['base_price']
						mineral_save.corp_rise = params[mineral.downcase]['margin']
						mineral_save.quantity = params[mineral.downcase]['qty']
						mineral_save.created_at = Time.now
						mineral_save.updated_at = Time.now						
						if(mineral_save.save) 
							redirect_to('/make_orders')
							puts(mineral_save)
							return #Important pour redirect_to !!!
						end
					end
				}
			end
		end

		def index
#		 	xmlfile = File.new('public/market.xml')
#		 	xmldoc = Document.new(xmlfile)
			content = Net::HTTP.get(URI.parse("http://api.eve-central.com/api/marketstat?typeid=34&typeid=35&typeid=36&typeid=37&typeid=38&typeid=39&typeid=40&regionlimit=10000042&regionlimit=10000030"));
			xmldoc = Document.new(content)

			@display_table = String.new
			@price_infos = Array.new

			xmldoc.elements.each('evec_api/marketstat/*') { |zeElement|
				if(zeElement.attributes['id'].length > 0)
					puts(@@minerals[zeElement.attributes['id'].to_i])
				end

				zeElement.elements.each('buy/avg') { |bigdamnprice|
					puts('Found dat price: ' + bigdamnprice.text)
					@price_infos += [{'name' => @@minerals[zeElement.attributes['id'].to_i], 'base_price' => bigdamnprice.text}]
				}
			}
		end
  end
