require 'sherloc'
require 'rainbow'
require 'json'

module Sherloc::AggregateOutput

    def self.run!(isMulti)

        puts Rainbow("\nAggregating output...").indianred
        
        vulerabilityArray = Array.new
        highVulerabilityArray = Array.new

        Dir.foreach('./json_files/') do |filename|
            next if filename == '.' or filename == '..'
            # Do work on the remaining files & directories
            file_path = './json_files/' + filename.to_s

            json_file = File.open(file_path).read
            data = JSON.parse(json_file)

            if data != []
                data.each_with_index do | item, index |
                    if item['Vulnerabilities'] != nil
                        item['Vulnerabilities'].each_with_index do | innerItem, innerIndex |
                            vulerabilityArray << { vulerabilityID: innerItem['VulnerabilityID'], target: item['Target'], pkgName: innerItem['PkgName'], severity: innerItem['Severity'] }
                            highVulerabilityArray << { vulerabilityID: innerItem['VulnerabilityID'], description: innerItem['Description'] } if innerItem['Severity'] == 'HIGH'
                        end
                    end
                end
            end
        end

        vulerability_count = Hash.new 0
        severity_count = Hash.new 0

        vulerabilityArray.each do |item|
            vulerability_count[item[:vulerabilityID]] += 1
            severity_count[item[:severity]] += 1
        end

        vulerability_count = vulerability_count.sort_by{|k, v| [-v, k]}

        puts "\n-------------------------------------------------------- REPORT --------------------------------------------------------"

        # puts vulerability_count
        puts Rainbow("\nVulnerability Severity\n").underline
        puts Rainbow(" HIGH: ").red.inverse + " " + severity_count['HIGH'].to_s + " " + Rainbow(" MEDIUM: ").yellow.inverse + " " + severity_count['MEDIUM'].to_s + " " + Rainbow(" LOW: ").green.inverse + " " + severity_count['LOW'].to_s

        puts Rainbow("\nTop Vulnerability ID Count\n").underline
        puts Rainbow("Count  |   Vulnerability ID\n\n")
        vulerability_count.each do | item |
            # puts item[0] + " => " + Rainbow(" " + item[1].to_s + " ").indianred.inverse if (item[1] > 1 || !isMulti)
            puts Rainbow("  " + item[1].to_s + "  ").indianred.inverse + "  =>  " + item[0] if (item[1] > 1 || !isMulti)
        end

        # Description of high severities if any
        if highVulerabilityArray != []
            puts Rainbow("\nHIGH Vulnerability Descriptions").underline
            
            highVulerabilityArray.each_with_index do | item, index |
                puts "\n" + (index + 1).to_s + ") " + Rainbow(" " + item[:vulerabilityID].to_s + " ").cyan.inverse + " - " + item[:description].to_s
            end
        end

        puts "\n--------------------------------------------------------- END ---------------------------------------------------------"

    end
end