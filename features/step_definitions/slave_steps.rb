#!/usr/bin/env ruby
# vim: tabstop=2 expandtab shiftwidth=2

Given /^a dumb slave$/ do
  @slave = Jenkins::Slave.dumb_slave(@base_url)
end

When /^I add the label "([^"]*)" to the slave$/ do |label|
  @slave.configure do
    @slave.labels = label
  end
end


Then /^I should see the job tied to the "([^"]*)" label$/ do |label|
  visit("/label/#{label}")
  step %{the page should say "#{@job.name}"}
end
