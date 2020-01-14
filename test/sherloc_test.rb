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


end