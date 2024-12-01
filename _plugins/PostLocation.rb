module Jekyll
    class PostLocation < Generator
      # generate perent x and y values for each post based on latitude and longitude
      def generate(site)
        site.posts.docs.each do |post|
          map_width = 100
          map_height = 100
          
          # get x value
          x = (post.data["longitude"] + 180) * (map_width / 360.0)
          
          # convert from degrees to radians
          lat_rad = post.data["latitude"] * Math::PI / 180
          
          # get y value
          merc_n = Math.log(Math.tan((Math::PI / 4) + (lat_rad / 2)))
          y = (map_height / 2) - (map_width * merc_n / (2 * Math::PI))

          post.data["x"] = x
          post.data["y"] = y
        end
      end
    end
  end