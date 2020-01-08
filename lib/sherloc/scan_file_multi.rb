require 'sherloc'
require 'rainbow'

module Sherloc::ScanFileMulti
    
    def self.run!(scan_file)
        puts Rainbow("Scanning code file: " + scan_file + "...\n").cyan.inverse
    end
end