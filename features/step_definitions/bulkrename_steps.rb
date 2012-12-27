Then /^the correct usage message should be displayed:$/ do |usage_message|
  assert_partial_output(usage_message, all_output)
  last_exit_status.should == 0
end
