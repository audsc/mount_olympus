# :first_in sets how long it takes before the job is first run. In this case, it is run immediately
require 'pipedrive-ruby'

pipedrive_api = ENV['PIPEDRIVE_API']
Pipedrive.authenticate(pipedrive_api)

SCHEDULER.every '10m', :first_in => 0 do |job|
  p = Pipedrive::Pipeline.find(1)
  stages = p['deals_summary']['per_stages']
  blob = []
  stages.each do |stageid , info|
    stage = Pipedrive::Stage.find(stageid)
    name = stage.name
    num = stage.order_nr
    target = "stage#{num}"
    value = info['USD']['value']
    count = info['USD']['count']
    d_value = "$#{value}"
    send_event(target, {title: name, current: count, moreinfo: d_value})
    #blob.push({label: name, value: info['USD']['value'], id: stageid})
  end
  #send_event('deals', {items: blob})
end
