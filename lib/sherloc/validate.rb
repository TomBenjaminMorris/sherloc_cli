require 'sherloc'
require 'rainbow'

module Sherloc::Validate

    def self.run!(options, scan_file)

        # Separate arguments and switches
        isMulti = options[:m]
        isCodeFile = options[:f]
        isImage = options[:i]
        
        # Detect file type
        isJS, file_ext = Sherloc::Detect.run!(scan_file)

        # File validation
        if isCodeFile && !isJS
            raise Rainbow("Only .js file types are supported for code scanning").red.inverse
        end

        if isImage && isJS
            raise Rainbow("Non-compatible file type for image scanning: " + file_ext).red.inverse
        end

        return [isMulti, isCodeFile, isImage]
    end
end