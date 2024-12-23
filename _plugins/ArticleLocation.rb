require 'uri'

module Jekyll
    class ArticleLocation < Generator
      # generate perent x and y values for each article based on latitude and longitude
      def generate(site)
        site.data['articles'].each do |article|
          article["source"] = URI.parse(article["url"]).host.sub(/^www\./, '')

          next unless article["longitude"] && article["latitude"]

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
          article["y"] = y
        end
      end
    end
  end