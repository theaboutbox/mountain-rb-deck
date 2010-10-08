Given /^I fill in these cards:$/ do |table|
  fill_in('card_list', :with => table.rows.join("\r\n"))
end

Then /^I should see a "([^"]*)" of (\d+)$/ do |arg1, arg2|
  selector = arg1.gsub(' ','_')
  with_scope("##{selector}") do
    page.should have_content(arg2)
  end
end

