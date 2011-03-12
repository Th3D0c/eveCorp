class PersoController < ApplicationController
	def index	
#		@minerals_id_index= {
#			11399 => 'Morphite',
#			34 => 'Tritanium',
#			35 => 'Pyerite',
#			36 => 'Mexallon',
#			37 => 'Isogen',
#			38 => 'Nocxium',
#			39 => 'Zydrine',
#			40 => 'Megacyte'
#		}

content = Net::HTTP.post_form(URI.parse("https://api.eveonline.com/char/CharacterSheet.xml.aspx"), 
{'apiKey' => '39EB48CB131C4D5792C170FE120B35CC008F513C95DE470397629609981563E6', 'characterID' => '90501427', 'userID' => '7518753'}	)
		xmldoc = Document.new(content)

@display_table = String.new
@price_infos = Array.new

xmldoc.elements.each('evec_api/result/*') { |zeElement|
	puts zeElement
}




		
		require 'eaal'
		api = EAAL::API.new("7518753", "39EB48CB131C4D5792C170FE120B35CC008F513C95DE470397629609981563E6")
		api.scope = "eve"
		result = api.CharacterID(:names => "Evee Browncoat")
		puts result.characters.first.characterID
#
		api.scope = "char"
		aaa = api.AssetList(:characterID => 90501427)
		puts aaa
		
		api.SkillQueue(:characterID => 90501427).skillqueue.each{|character|
		puts character.endTime
#		puts character.quantity
		}
		
		
		
		api.AssetList(:characterID => 90501427).assets.each{|character|
		puts character.itemID
		puts character.quantity
		}
		
		
		api.scope = "char"                                    # set scope to "char"
  		kills = api.CharacterSheet(:characterID => 90501427).result    
  		puts kills
## 
#
#require 'eaal'
#  EAAL.cache = EAAL::Cache::FileCache.new               # set cache
# api = EAAL::API.new("7518753", "4EC63B1FF3904842A67487605060509067F50DF5EB4E438AB76ACE6F0B2C097F")
#  charid = api.Characters.characters.first.characterID  # get the characterID of the first character on account
#  api.scope = "char"                                    # set scope to "char"
#  kills = api.CharacterSheet("characterID" => charid).race    # request Killlog API Page
#  puts kills








#
#		puts api.CharacterSheet("characterID" => "12345" 
#		result = api.Characters
##		puts result.characters
#		result.characters.each{|character|
#		puts character.name
#		}

	end
end

