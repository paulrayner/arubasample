Then /^the correct usage message should be displayed:$/ do |usage_message|
#  usage_message = %Q{USAGE: bulkrename <folder name> <find extension> <replace extension>}
  assert_partial_output(usage_message, all_output)
  last_exit_status.should == 0
end
