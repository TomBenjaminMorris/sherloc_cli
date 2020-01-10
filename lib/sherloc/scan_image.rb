require 'sherloc'
require 'rainbow'

module Sherloc::ScanImage

    def self.run!(scan_file)

        puts Rainbow("Clearing old json files...\n").indianred
        system('rm ./json_files/* 2> /dev/null')
        puts Rainbow(" Attempting scan on image: " + scan_file + ".. \n").cyan.inverse
        system("trivy --skip-update -f json -o ./json_files/results.json " + scan_file);
        puts Rainbow("\n Completed scan of " + scan_file + " \n").blue.inverse

    end
end