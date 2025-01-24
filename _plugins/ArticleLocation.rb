require 'uri'

module Jekyll
    class ArticleLocation < Generator
      # generate fraction x and y values for each article based on latitude and longitude
      def generate(site)
        site.data['articles'].each do |article|
          host = URI.parse(article["url"]).host
          article["source"] = host.nil? ? '' : host.sub(/^www\./, '')

        next unless article["longitude"] && article["latitude"]

        map_top_cropping = 14.5
        map_bottom_cropping = 29.01

        map_width = 100
        map_height = 100
        
        # get x value
        x = (article["longitude"] + 180) * (map_width / 360.0)
        
        # convert from degrees to radians
        lat_rad = article["latitude"] * Math::PI / 180
        
        # get y value
        merc_n = Math.log(Math.tan((Math::PI / 4) + (lat_rad / 2)))
        y = (map_height / 2) - (map_width * merc_n / (2 * Math::PI))

        article["x"] = x

        y = ((y / 100) - (map_top_cropping / map_height)) / (1 - (map_top_cropping / map_height)) * 100
        y = ((y / 100) / (1 - (map_bottom_cropping / (map_height - map_top_cropping)))) * 100

        article["y"] = y
      end
    end
  end
  end