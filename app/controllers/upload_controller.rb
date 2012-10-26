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
    @attributes = { '1-1' => 0, '15-1' => 0, '21-1' => 0, '27-1' => 0, '32-1' => 0, '38-1' => 0, '43-1' => 0, '5-1' => 0, '55-1' => 0, '60-1' => 0, '7-1' => 0, '10-1' => 0, '17-1' => 0, '22-1' => 0, '28-1' => 0, '33-1' => 0, '39-1' => 0, '44-1' => 0, '50-1' => 0, '56-1' => 0, '62-1' => 0, '8-1' => 0, '11-1' => 0, '18-1' => 0, '23-1' => 0, '29-1' => 0, '34-1' => 0, '4-1' => 0, '46-1' => 0, '51-1' => 0, '57-1' => 0, '63-1' => 0, '9-1' => 0, '12-1' => 0, '19-1' => 0, '24-1' => 0, '3-1' => 0, '35-1' => 0, '40-1' => 0, '47-1' => 0, '52-1' => 0, '58-1' => 0, '64-1' => 0, '13-1' => 0, '2-1' => 0, '25-1' => 0, '30-1' => 0, '36-1' => 0, '41-1' => 0, '48-1' => 0, '53-1' => 0, '59-1' => 0, '65-1' => 0, '14-1' => 0, '20-1' => 0, '26-1' => 0, '31-1' => 0, '37-1' => 0, '42-1' => 0, '49-1' => 0, '54-1' => 0, '6-1' => 0, '66-1' => 0, '1-0' => 0, '15-0' => 0, '21-0' => 0, '27-0' => 0, '32-0' => 0, '38-0' => 0, '43-0' => 0, '5-0' => 0, '55-0' => 0, '60-0' => 0, '7-0' => 0, '10-0' => 0, '17-0' => 0, '22-0' => 0, '28-0' => 0, '33-0' => 0, '39-0' => 0, '44-0' => 0, '50-0' => 0, '56-0' => 0, '62-0' => 0, '8-0' => 0, '11-0' => 0, '18-0' => 0, '23-0' => 0, '29-0' => 0, '34-0' => 0, '4-0' => 0, '46-0' => 0, '51-0' => 0, '57-0' => 0, '63-0' => 0, '9-0' => 0, '12-0' => 0, '19-0' => 0, '24-0' => 0, '3-0' => 0, '35-0' => 0, '40-0' => 0, '47-0' => 0, '52-0' => 0, '58-0' => 0, '64-0' => 0, '13-0' => 0, '2-0' => 0, '25-0' => 0, '30-0' => 0, '36-0' => 0, '41-0' => 0, '48-0' => 0, '53-0' => 0, '59-0' => 0, '65-0' => 0, '14-0' => 0, '20-0' => 0, '26-0' => 0, '31-0' => 0, '37-0' => 0, '42-0' => 0, '49-0' => 0, '54-0' => 0, '6-0' => 0, '66-0' => 0 }
    home_loc=LatLng.new(62.2341133,25.8164888)
    @countries = {}
    @maxdt = 0
    @ftf = []
    @albhabets = {}
    @m = {}
    @ratings.each{|tr|
     @m[tr] = {}
     @ratings.each{|dr|
       @m[tr][dr] = 0
     } 
    }
    doc.xpath('//attribute').each{|attribute|
      attr_name = "#{attribute['id']}-#{attribute['inc']}"
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

      if(!@albhabets[cache['name'][0]])
        @albhabets[cache['name'][0]] = cache['name']
      end

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
