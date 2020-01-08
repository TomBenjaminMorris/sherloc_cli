require 'sherloc'
require 'rainbow'

module Sherloc::ScanImageMulti

    def self.run!(f_lines)
        f_lines.each_with_index do |line, index|
            puts Rainbow("Scanning: " + line + "...").cyan.inverse
            system("trivy --skip-update -f json -o ./json_files/results" + (index+1).to_s + ".json " + line);
            puts Rainbow("Completed scan of " + line).blue.inverse
        end
    end
end