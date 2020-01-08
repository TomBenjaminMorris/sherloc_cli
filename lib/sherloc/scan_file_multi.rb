require 'sherloc'
require 'rainbow'

module Sherloc::ScanFileMulti
    
    def self.run!(scan_file)
        puts Rainbow("Scanning code file: " + scan_file + "...").cyan.inverse
    end
end