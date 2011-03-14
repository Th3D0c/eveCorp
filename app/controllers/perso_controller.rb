class PersoController < ApplicationController
#	require 'ruby-debug'
#	debugger
	require 'ostruct'
	require 'rexml/document'
	include REXML
		
	
	
	def recurse(the_element)
		buffer =  Hash.new
		the_element.elements.each do |childElement|
			if(childElement.has_elements?)
				buffer[childElement.name] = OpenStruct.new recurse(childElement)
			else
				buffer[childElement.name] = childElement.text
			end
		end
		return  buffer
	end
	
	def recurse2(the_element)
		buffer =  Hash.new
		att_list = the_element.attributes["columns"].split(',')
		att_key = the_element.attributes["key"].to_s
		
		the_element.elements.each do |childElement|
			if(childElement.has_elements?)
				buffer[childElement.name] = OpenStruct.new recurse(childElement)
				
			else				
				row =  Hash.new
				childElement.attributes.each_attribute {|attr|
					row[attr.expanded_name] = attr.value
				}
				buffer[row[att_key].to_i] = OpenStruct.new row
				
				if(the_element.attributes['name'] == 'skills')
#					puts buffer[zeElement.attributes['name']+buffer1[att_key]]
					p row['skillpoints'].to_i
					@@charac['skillsPoints'] += row['skillpoints'].to_i
				end
			end
		end
		
#		p 'aaa', aaa
#		p 'bbb', bbb
#		p 'bbb', bbb[3300]
		
#		buffer[childElement.attributes['name']] = childElement.text
		return  buffer
	end
	
	def index
		content = Net::HTTP.post_form(URI.parse("http://api.eveonline.com/char/CharacterSheet.xml.aspx"), 
		{'apiKey' => '39EB48CB131C4D5792C170FE120B35CC008F513C95DE470397629609981563E6', 'characterID' => '90501427', 'userID' => '7518753'}	)

		xmldoc = Document.new(content.body) 
	
		@@charac =  Hash.new
		@@charac['skillsPoints'] = 0
		xmldoc.elements.each('eveapi/result/*') { |zeElement|
			puts zeElement
			puts zeElement.name
			puts zeElement.text
			puts zeElement.has_elements?
			puts zeElement.has_attributes?
			puts zeElement.attributes["name"]
			if (zeElement.has_elements? == false && zeElement.has_attributes? == false)
				@@charac[zeElement.name] = zeElement.text.to_s
			elsif (zeElement.has_elements? == true && zeElement.has_attributes? == false)
				
								
				puts OpenStruct.new recurse(zeElement)				
				@@charac[zeElement.name] = OpenStruct.new recurse(zeElement)
			elsif (zeElement.name == 'rowset')
				puts recurse2(zeElement)
				@@charac[zeElement.attributes['name']] = recurse2(zeElement)
#				
#				buffer =  Hash.new		
#				if (zeElement.has_elements? == true)
#					att_list = zeElement.attributes["columns"].split(',')
#					att_key = zeElement.attributes["key"].to_s
##					att_list.delete('unpublished')		# Hack characterSheat
##					puts att_list
#					
#					zeElement.elements.each('*') { |zeElementType1|
#						buffer1 =  Hash.new
#						att_list.each { |att| 
##							puts zeElementType1.attributes[att]
#							if(att == 'unpublished' && zeElementType1.attributes[att].nil? == false)
#								buffer1['level'] = zeElementType1.attributes[att] 
#							else
#								buffer1[att] = zeElementType1.attributes[att]
#							end
#							
#						}
#						buffer[zeElement.attributes['name']+buffer1[att_key]] = OpenStruct.new buffer1
#						
#						if(zeElement.attributes['name'] == 'skills')
##							puts buffer[zeElement.attributes['name']+buffer1[att_key]]
#							charac['skillsPoints'] += buffer[zeElement.attributes['name']+buffer1[att_key]].skillpoints.to_i
#						end
#					}
#				end
#				charac[zeElement.attributes['name']] = OpenStruct.new buffer
			end
		}
		@characterSheat = OpenStruct.new @@charac
		puts "\n\n\n===============================\n\n\n"
		puts @characterSheat
	end
end

