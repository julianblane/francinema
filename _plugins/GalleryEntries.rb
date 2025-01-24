module Jekyll
    class GalleryEntry < Generator
      def generate(site)
        site.data['gallery'] ||= []
        Dir.glob('assets/gallery/**/*').each do |file|
          next unless File.file?(file)
          
          # TODO: calculate image aspect ratio

          category = File.dirname(file).split('/').last
          site.data['gallery'] << { 
            'img' => File.basename(file),
            'category' => category
          }
        end
      end
    end
  end