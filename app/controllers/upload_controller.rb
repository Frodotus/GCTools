require 'nokogiri'
require 'open-uri'
require 'matrix'
class UploadController < ApplicationController
  def index  
  end
  
  def upload
   data = ""
   if params[:gpx]
     data = params[:gpx].read

    doc = Nokogiri::XML(data)
    #@doc.xpath("//xmlns:wptname").each{|wpt|
    #  wpt.xpath("//name").each{|name|
    #    puts name
    #  }
    #puts wpt
    #}
    doc.remove_namespaces!
    i = dif = ter = 0
    @ratings = '1','1.5','2','2.5','3','3.5','4','4.5','5'
    @countries = {}
    @maxdt = 0
    @attributes = {}
    @m = {}
    @ratings.each{|tr|
     @m[tr] = {}
     @ratings.each{|dr|
       @m[tr][dr] = 0
     } 
    }
    doc.xpath('//attribute').each{|attribute|
      attr_name = "#{attribute.text} #{attribute['id']}-#{attribute['inc']}"
      if @attributes[attr_name] 
        @attributes[attr_name] = @attributes[attr_name]+1
      else
        @attributes[attr_name] = 1
      end      
    }
    doc.xpath("//wpt").each { |wpt|
      i = i + 1
      name = wpt.search("name").first.text
      difficulty = wpt.xpath('cache/difficulty').text
      terrain = wpt.xpath('cache/terrain').text
      dif = dif + difficulty.to_f
      ter = ter + terrain.to_f  
      if(@m[terrain][difficulty])
        @m[terrain][difficulty] = @m[terrain][difficulty] + 1
      else
        @m[terrain][difficulty] = 1
      end
      if @m[terrain][difficulty] > @maxdt
        @maxdt = @m[terrain][difficulty]
      end
  country = wpt.xpath('cache/country').text
  if(@countries[country])
    @countries[country] = @countries[country] + 1
  else
    @countries[country] = 1
  end
    }
    @countries = @countries.sort {|a,b| b[1] <=> a[1]} 
    @attributes = @attributes.sort {|a,b| b[1] <=> a[1]} 
    p @countries
    #m.keys.each{|key|
    #  m[key].keys.each{|k|
    #    puts k;
    #  } 
    #} 
    
   end

  end
end
