require 'nokogiri'
require 'open-uri'
require 'matrix'

doc = Nokogiri::XML(File.open("finds.gpx"))
#@doc.xpath("//xmlns:wptname").each{|wpt|
#  wpt.xpath("//name").each{|name|
#    puts name
#  }
#puts wpt
#}
doc.remove_namespaces!
i = 0
dif = 0
@countries = {}
ter = 0
maxdt = 0
m = {}
ratings = '1','1.5','2','2.5','3','3.5','4','4.5','5'
ratings.each{|tr|
 m[tr] = {}
 ratings.each{|dr|
   m[tr][dr] = 0
 } 
}
doc.xpath("//wpt").each { |wpt|
  i = i + 1
  name = wpt.search("name").first.text
  difficulty = wpt.xpath('cache/difficulty').text
  terrain = wpt.xpath('cache/terrain').text
  country = wpt.xpath('cache/country').text
  if(@countries[country])
    @countries[country] = @countries[country] + 1
  else
    @countries[country] = 1
  end
  dif = dif + difficulty.to_f
  ter = ter + terrain.to_f  
  if(m[terrain][difficulty])
    m[terrain][difficulty] = m[terrain][difficulty] + 1
  else
    m[terrain][difficulty] = 1
  end
  if m[terrain][difficulty] > maxdt
    maxdt = m[terrain][difficulty]
  end
  puts "Name: #{name} lon: #{wpt['lon']} lat: #{wpt['lat']}" 
  puts "      #{difficulty}/#{terrain}" 
  puts "      #{difficulty}/#{terrain}" 
  puts "      #{(dif/i).round(2)}/#{(ter/i).round(2)}"
}

puts
ratings.each{|tr|
 ratings.each{|dr|
   color = 0
   color = (55+(m[tr][dr]*1.0)/maxdt*200).round if m[tr][dr] > 0
   print "#{m[tr][dr]}/#{color}\t"
 } 
 print "\n"
}
#m.keys.each{|key|
#  m[key].keys.each{|k|
#    puts k;
#  } 
#} 
p @countries