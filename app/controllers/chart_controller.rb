require 'googlecharts'
include GeoKit

class ChartController < ApplicationController

  def img4
    image = Magick::Image.new(130, 50){self.background_color = "#FFFFFF"}
    image.background_color = 'red'
    text = Magick::Draw.new
    text.encoding = "Unicode"
    text.text(20,20,"FTF Loydot:")
    text.draw(image)
    respond_to do |format|
      format.html 
      format.png { 
        image.format = 'png'
        send_data image.to_blob, :type => 'image/png', :disposition => 'inline', :filename => 'img.png' 
        }
      format.svg {
        image.format = 'svg'
        send_data image, :type => 'image/svg+xml', :disposition => 'inline', :filename => 'img.svg' 
        }
    end  
  end
   
  def cache_types_pie
    redirect_to(Gchart.pie_3d(:title => "K%C3%A4tk%C3%B6tyypit",
                              :size => '560x280',
                              :data => [821, 113, 40],
                              :bar_colors => '00DD00,DDDD00,0000DD',
                              :labels => ["Tradit (821)", "Multit (113)", "Mysteerit (40)"]
                              ))
  end
  
  def img
    redirect_to(Gchart.pie_3d(:data => [20, 35, 45]))
  end
  
  def img3
    g = Gruff::Line.new
    g.title = "My Graph" 
    
    g.data("Tradi", [100, 121, 112, 311, 311, 200])
    g.data("Multi", [4, 8, 7, 9, 8, 9])
    g.data("Mystery", [2, 3, 1, 5, 6, 8])
     
    g.labels = {0 => '2003', 2 => '2004', 4 => '2005'}
    send_data g.to_blob, :type => 'image/png', :disposition => 'inline', :filename => 'img.png' 
  end

end
