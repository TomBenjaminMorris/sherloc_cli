require 'sherloc'
require 'rainbow'

module Sherloc::ParseMulti

    def self.run!(scan_file, isImage, isCodeFile)
        
        file_ext = File.extname(scan_file)
        isJS = file_ext == ".js"

        puts Rainbow("Attempting to parse multi file...\n").cyan
        f_lines = File.open(scan_file).read.split("\n")

        f_lines.each_with_index do |line, index|

            file_ext = File.extname(line)
            isJS = file_ext == ".js"

            if (isCodeFile && !isJS) || (isImage && isJS)
                raise Rainbow("Unsupported file type in multi file\n").red.inverse
            end
        end

        return f_lines
    end
end