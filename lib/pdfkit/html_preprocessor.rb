class PDFKit
  module HTMLPreprocessor

    # Change relative paths to absolute, and relative protocols to absolute protocols
    def self.process(html, root_url, protocol)
      html = translate_relative_paths(html, root_url) if root_url
      html = translate_relative_protocols(html, protocol) if protocol
      html
    end

    private

    def self.translate_relative_paths(html, root_url)
      # Try out this regexp using rubular http://rubular.com/r/hiAxBNX7KE
      html.gsub(/(href|src)=(['"])\/([^\/"']([^\"']*|[^"']*))?['"]/, "\\1=\\2#{root_url}\\3\\2")
      # Try out this regex using rubular https://rubular.com/r/VOeeYjkuRi1meA
      html.gsub(/url\(\s*(['"]?)(.*?)\1\s*\)/, "url('#{root_url}\\2')")
    end

    def self.translate_relative_protocols(body, protocol)
      # Try out this regexp using rubular http://rubular.com/r/0Ohk0wFYxV
      body.gsub(/(href|src)=(['"])\/\/([^\"']*|[^"']*)['"]/, "\\1=\\2#{protocol}://\\3\\2")
      # Try out this regex using rubular https://rubular.com/r/VOeeYjkuRi1meA
      body.gsub(/url\(\s*(['"]?)(.*?)\1\s*\)/, "url('#{protocol}://\\2')")
    end
  end
end
