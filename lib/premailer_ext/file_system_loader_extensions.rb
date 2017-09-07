require 'addressable/uri'

class Premailer
  module Rails
    module CSSLoaders
      module FileSystemLoader
        def load(url)
          path = Addressable::URI.parse(url).path
          file_path = "public#{path}"
          File.read(file_path) if File.exist?(file_path)
        end
      end
    end
  end
end
