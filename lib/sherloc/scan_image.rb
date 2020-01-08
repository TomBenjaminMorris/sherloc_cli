require 'sherloc'
require 'rainbow'

module Sherloc::ScanImage

    def self.run!(scan_file)

        puts Rainbow("Attempting scan on image: " + scan_file + "..\n").cyan.inverse
        system("trivy --skip-update -f json -o ./json_files/results.json " + scan_file);
        puts Rainbow("\nCompleted scan of " + scan_file + "\n").blue.inverse

    end
end