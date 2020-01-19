require 'test_helper'

class DefaultTest < Test::Unit::TestCase
    
    def setup
        @scan_file_js = 'test.js'
        @scan_file_java = 'test.java'
        @scan_file_image = 'alpine'
        @options_file_single = {"f"=>true, :f=>true, "file"=>true, :file=>true, "m"=>false, :m=>false, "multi-scan"=>false, :"multi-scan"=>false, "i"=>false, :i=>false, "image"=>false, :image=>false}
        @options_image_single = {"f"=>false, :f=>false, "file"=>false, :file=>false, "m"=>false, :m=>false, "multi-scan"=>false, :"multi-scan"=>false, "i"=>true, :i=>true, "image"=>true, :image=>true}
        @options_file_multi = {"f"=>true, :f=>true, "file"=>true, :file=>true, "m"=>true, :m=>true, "multi-scan"=>true, :"multi-scan"=>true, "i"=>false, :i=>false, "image"=>false, :image=>false}
        @options_image_multi = {"f"=>false, :f=>false, "file"=>false, :file=>false, "m"=>true, :m=>true, "multi-scan"=>true, :"multi-scan"=>true, "i"=>true, :i=>true, "image"=>true, :image=>true}
    end

    def test_that_it_has_a_version_number
        refute_nil ::Sherloc::VERSION
    end

    # detect.rb

    def test_detect_file_positive
        isJS, ext = Sherloc::Detect.run!(@scan_file_js)
        assert isJS
    end

    def test_detect_file_negative
        isJS, ext = Sherloc::Detect.run!(@scan_file_java)
        assert !isJS
    end

    # validate.rb

    def test_validation_js_file
        isMulti, isCode, isImage = Sherloc::Validate.run!(@options_file_single, @scan_file_js)
        assert isMulti == false && isCode == true && isImage == false
    end

    def test_validation_js_file_negative
        assert_raise RuntimeError do
            isMulti, isCode, isImage = Sherloc::Validate.run!(@options_file_single, @scan_file_java)
        end
    end

    def test_validation_js_image_negative
        assert_raise RuntimeError do
            isMulti, isCode, isImage = Sherloc::Validate.run!(@options_image_single, @scan_file_js)
        end
    end

    def test_validation_js_image
        isMulti, isCode, isImage = Sherloc::Validate.run!(@options_image_single, @scan_file_image)
        assert isMulti == false && isCode == false && isImage == true
    end

    # Scan Image single

    def test_single_image_scan
        Sherloc::ScanImage.run!(@scan_file_image)
        file_path = './json_files/results.json'
        json_file = File.open(file_path).read
        assert json_file != nil
    end

    def test_single_image_scan_negative
        assert_raise 'Errno::ENOENT(<No such file or directory @ rb_sysopen - ./bad_path/results.json>)' do
            Sherloc::ScanImage.run!(@scan_file_image)
            file_path = './bad_path/results.json'
            json_file = File.open(file_path).read
        end
    end

    # Parse Multi File

    def test_parse_multi_image_file
        File.open "./test_image_file_test", 'w' do |file| 
            file.write "alpine\nalpine"
            file.close
        end
        f_lines = Sherloc::ParseMulti.run!('./test_image_file_test', true, false)
        assert f_lines != nil
        File.delete("./test_image_file_test")
    end

    def test_parse_multi_image_file_with_js
        assert_raise RuntimeError do
            File.open "./test_image_file_test", 'w' do |file| 
                file.write "alpine.js\nalpine.js"
                file.close
            end
            f_lines = Sherloc::ParseMulti.run!('./test_image_file_test', true, false)
            assert f_lines != nil
        end
        File.delete("./test_image_file_test")
    end

    # Scan Image Multi

    def test_scan_multi_image
        File.open "./test_image_file_test", 'w' do |file| 
            file.write "alpine\nalpine"
            file.close
        end
        f_lines = Sherloc::ParseMulti.run!('./test_image_file_test', true, false)
        Sherloc::ScanImageMulti.run!(f_lines)

        file_path1 = './json_files/results1.json'
        file_path2 = './json_files/results2.json'
        json_file1 = File.open(file_path1).read
        json_file2 = File.open(file_path2).read

        assert json_file1 != nil && json_file2 != nil

        File.delete("./test_image_file_test")
        File.delete("./json_files/results1.json")
        File.delete("./json_files/results2.json")
    end

    def test_scan_multi_image_negative
        assert_raise 'Errno::ENOENT: No such file or directory @ rb_sysopen - ./json_files/results1.json' do
            file_path1 = './json_files/results1.json'
            file_path2 = './json_files/results2.json'
            json_file1 = File.open(file_path1).read
            json_file2 = File.open(file_path2).read
        end
    end
    
    
    
    
    
    
    
end