require 'sherloc'
require 'rainbow'

module Sherloc::ScanImage

    def self.run!(scan_file)

        puts "image scan single: " + scan_file
        puts Rainbow("Attempting scan on image: " + scan_file + "...").cyan.inverse
        system("trivy --skip-update -f json -o ./json_files/results.json " + scan_file);
        puts Rainbow("Completed scan of " + scan_file).blue.inverse

    end
end