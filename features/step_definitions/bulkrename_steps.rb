Then /^the correct usage message should be displayed:$/ do |usage_message|
  assert_partial_output(usage_message, all_output)
  last_exit_status.should == 0
end

Then /^the program should exit by displaying the error:$/ do |error_message|
  assert_partial_output(error_message, all_output)
  last_exit_status.should == 1
end

Given /^some text files$/ do
  steps %Q{
    Given an empty file named "textfiles/May-financials.txt"
    And an empty file named "textfiles/June-financials.TXT"
    And an empty file named "textfiles/July-financials.TXT"
  }
end

Then /^the files should be renamed correctly$/ do
  step "the following files should exist:", table(%{
    | textfiles/May-financials.csv |
    | textfiles/June-financials.csv |
    | textfiles/July-financials.csv |
  })
end

Given /^the following files in the folder "(.*?)":$/ do |folder, files_table|
  files_table.hashes.each do |hash|
  	pp "** #{files_table} **"
  	new_file = "#{folder}/#{hash['link']}"
  	puts new_file
    step "an empty file named \"#{new_file}\""
  end
end