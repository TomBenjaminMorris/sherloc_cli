require 'sherloc'
require 'rainbow'

module Sherloc::Validate

    def self.run!(options, args)

        # Separate arguments and switches

        scan_file = args[0]
        isMulti = options[:m]
        isCodeFile = options[:c]
        isImage = options[:i]
        
        file_ext = File.extname(scan_file)
        isJS = file_ext == ".js"

        # File validation

        if isCodeFile && !isJS
            raise Rainbow("Only .js file types are supported for code scanning").red.inverse
        end

        if isImage && isJS
            raise Rainbow("Non-compatible file type for image scanning: " + file_ext).red.inverse
        end
    end
end