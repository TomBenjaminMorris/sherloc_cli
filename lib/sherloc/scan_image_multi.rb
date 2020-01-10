require 'sherloc'
require 'rainbow'

module Sherloc::ScanImageMulti

    def self.run!(f_lines)

        puts Rainbow("Clearing old json files...").indianred
        system('rm ./json_files/* 2> /dev/null')

        f_lines.each_with_index do |line, index|
            puts Rainbow("\n Scanning: " + line + "... \n").cyan.inverse
            system("trivy --skip-update -f json -o ./json_files/results" + (index+1).to_s + ".json " + line);
            puts Rainbow("\n Completed scan of " + line + " ").blue.inverse + "\n"
        end
        
    end
end