require 'sherloc'
require 'rainbow'
require 'json'

module Sherloc::AggregateOutput

    def self.run!(isImage)
        puts Rainbow("Aggregating output...").indianred
        json_file = File.open('./json_files/results.json').read
        data = JSON.parse(json_file)

        vulerabilityArray = Array.new

        data.each_with_index do | item, index |
            item['Vulnerabilities'].each_with_index do | innerItem, innerIndex |
                vulerabilityArray << { vulerabilityID: innerItem['VulnerabilityID'], target: item['Target'], pkgName: innerItem['PkgName'], severity: innerItem['Severity'] }
            end
        end

        vulerability_count = Hash.new 0
        severity_count = Hash.new 0

        vulerabilityArray.each do |item|
            vulerability_count[item[:vulerabilityID]] += 1
            severity_count[item[:severity]] += 1
        end

        vulerability_count.sort_by {|_key, value| value}

        # puts vulerability_count
        puts Rainbow("\nVulnerability Severity\n").underline
        puts Rainbow(" HIGH: ").red.inverse + " " + severity_count['HIGH'].to_s + " " + Rainbow(" MEDIUM: ").yellow.inverse + " " + severity_count['MEDIUM'].to_s + " " + Rainbow(" LOW: ").green.inverse + " " + severity_count['LOW'].to_s

        puts Rainbow("\nVulnerability IDs\n").underline
        vulerability_count.keys.each do | item |
            puts item + " => " + vulerability_count[item].to_s
        end

    end
end