require 'sherloc'
require 'rainbow'

module Sherloc::Detect

    def self.run!(scan_file)
        file_ext = File.extname(scan_file)
        isJS = file_ext == ".js"
        return [isJS, file_ext]
    end
end