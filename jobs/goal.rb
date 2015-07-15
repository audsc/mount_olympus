# :first_in sets how long it takes before the job is first run. In this case, it is run immediately
require 'httparty'
require 'json'
pipedrive_api = ENV["PIPEDRIVE_API"]

SCHEDULER.every '10s', :first_in => 0 do |job|
  send_event('example_widget', {value: '22', moreinfo: 'Example text'})
end
