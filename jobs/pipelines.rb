require 'pipedrive-ruby'

pipedrive_api = ENV['PIPEDRIVE_API']
Pipedrive.authenticate(pipedrive_api)

#first_in sets how long it takes before the job is first run. In this case, it is run immediately
SCHEDULER.every '10m', :first_in => 0 do |job| 
  p = Pipedrive::Pipeline.find(1)
  total_count = p.deals_summary['per_currency_full']['USD']['count']
  total_value = p.deals_summary['per_currency_full']['USD']['value']

  #p = Pipedrive::Pipeline.find(2)
  #upsells_count = p.deals_summary['per_currency_full']['USD']['count']
  #upsells_value = p.deals_summary['per_currency_full']['USD']['value']
  
   
  #p = Pipedrive::Pipeline.find(3)
  #whales_count = p.deals_summary['per_currency_full']['USD']['count']
  #whales_value = p.deals_summary['per_currency_full']['USD']['value']
  
  
  #send_event('standard_pipeline',  {title: 'Standard Pipeline', current: standard_count, moreinfo: standard_value})
  #send_event('upsells_pipeline', {title: 'Upsells Pipeline' , current: upsells_count, moreinfo: upsells_value})
  #send_event('whales_pipeline', {title: 'Whales Pipeline', current: whales_count, moreinfo: whales_value})
  #total_count = standard_count+upsells_count+whales_count
  #total_value = standard_value+upsells_value+whales_value
  send_event('overall_pipeline', {title: 'Total', current: total_count, moreinfo: total_value})
end

