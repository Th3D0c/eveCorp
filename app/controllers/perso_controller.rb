class PersoController < ApplicationController
#	require 'ruby-debug'
#	debugger
	require 'ostruct'
	require 'rexml/document'
	include REXML
			
	def index
	
	
		require 'eaal'
		EAAL.cache = EAAL::Cache::FileCache.new               # set cache
		api = EAAL::API.new("7518753", "39EB48CB131C4D5792C170FE120B35CC008F513C95DE470397629609981563E6")        # initialize API object
		api.scope = "char"                                    # set scope to "char"
		@characterSheat = api.CharacterSheet("characterID" => 90501427)    # request Killlog API Page
		@skillQueue = api.SkillQueue("characterID" => 90501427)
		
		api.scope = "eve"                                    # set scope to "char"
		@skillTree = api.SkillTree()
		
		# On crée un tableau de skill names car ca va servir dans la vue
		@skillNames = Array.new()		
		@skillTree.skillGroups.each() { |skillGroup| 			
			skillGroup.skills.each() { |skill|
				@skillNames[skill.typeID.to_i] = skill.typeName
			}
		}
		
		# On crée un tableau de skill names car ca va servir dans la vue
		@knownSkills = Array.new()		
		@characterSheat.skills.each() { |skill| 						
			@knownSkills[skill.typeID.to_i] = skill.level			
		}


		puts "\n\n\n===============================\n\n\n"
		puts @characterSheat
	end
end
