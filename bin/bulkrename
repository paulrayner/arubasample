#!/usr/bin/env ruby
$: << File.expand_path("../lib/", __FILE__)
require 'thor'

class Test < Thor
  desc "rename FOLDER", "Rename file extensions in designated folder"
  method_option :folder, :aliases => "-f", :default => nil, :desc => "Path to folder to containing files to rename"
  method_option :find_type, :aliases => "-x", :default => nil, :desc => "Extension to rename for matching files"
  method_option :replace_type, :aliases => "-r", :default => nil, :desc => "New file extension"
  def example
    puts "I'm a thor task!"
  end

end

Test.start