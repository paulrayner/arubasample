#!/usr/bin/env ruby
$: << File.expand_path("../lib/", __FILE__)
require 'thor'

class BulkRenameCLI < Thor
  desc "extension <folder> <old> <new>", "Rename file extensions in designated folder"
  method_option :overwrite, :aliases => "-o", :default => nil, :desc => "Overwrite any existing files"
  method_option :prompt_overwrite, :aliases => "-p", :default => nil, :desc => "Prompt before overwriting any existing file"
  method_option :copy_files, :aliases => "-c", :default => nil, :desc => "Copy files to new folder"
  def extension
    puts "Rename files by replacing the file extension"
  end

end

BulkRenameCLI.start