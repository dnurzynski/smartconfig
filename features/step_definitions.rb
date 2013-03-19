Given /^SmartConfig definition$/ do |string|
  @config = eval string
end

When /^I access "(.*?)"$/ do |arg1|
  @result = @config.send arg1
end

Then /^I should receive "(.*?)"$/ do |arg1|
  @result == arg1
end
