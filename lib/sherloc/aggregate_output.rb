require 'sherloc'
require 'rainbow'
require 'json'

module Sherloc::AggregateOutput

    def self.run!(isImage)
        puts Rainbow("Aggregating output...").indianred.inverse
        json_file = File.open('./json_files/results.json').read
        data = JSON.parse(json_file)
        # puts data[0]['Vulnerabilities']

        vulerabilityArray = Array.new

        data.each_with_index do | item, index |
            # puts item['Target']
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

        puts vulerability_count
        puts severity_count

    end
end