require 'nokogiri'
require 'open-uri'
require 'googlecharts'
include GeoKit

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
    dif = ter = 0
    @ratings = '1','1.5','2','2.5','3','3.5','4','4.5','5'
    home_loc=LatLng.new(62.2341133,25.8164888)
    @countries = {}
    @maxdt = 0
    @ftf = []
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
      cache = {}
      cache['id'] = wpt.search("name").first.text
      cache['name'] = wpt.xpath("cache/name").text
      cache['difficulty'] = wpt.xpath('cache/difficulty').text
      cache['terrain'] = wpt.xpath('cache/terrain').text
      cache['log'] = wpt.xpath('cache/logs/log').text
      cache['ftf'] = cache['log'].split("\n")[4].match('FTF')
      cache['loc'] = LatLng.new(wpt["lat"],wpt["lon"])
      cache['dist'] = home_loc.distance_to(cache['loc'])

      @ftf << cache if cache['ftf']
      
      dif = dif + cache['difficulty'].to_f
      ter = ter + cache['terrain'].to_f  
      if(@m[cache['terrain']][cache['difficulty']])
        @m[cache['terrain']][cache['difficulty']] = @m[cache['terrain']][cache['difficulty']] + 1
      else
        @m[cache['terrain']][cache['difficulty']] = 1
      end
      if @m[cache['terrain']][cache['difficulty']] > @maxdt
        @maxdt = @m[cache['terrain']][cache['difficulty']]
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
    #@cod = MultiGeocoder.geocode('vainolantie 25, 40420 Jyska, Finland')
    
   end

  end
end
