Then /^the correct usage message should be displayed:$/ do |usage_message|
  usage_message = 
  %Q{USAGE: bulkrename <folder name> <find_extension> <replace_extension>
some more text here
}
  assert_partial_output(usage_message, all_output)
end
