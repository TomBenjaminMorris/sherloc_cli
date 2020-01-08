require 'sherloc'
require 'rainbow'

module Sherloc::ScanFile

    def self.run!(scan_file)
        puts Rainbow("Scanning code file: " + scan_file + "...").cyan.inverse
    end
end