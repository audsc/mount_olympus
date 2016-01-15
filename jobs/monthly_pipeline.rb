# :first_in sets how long it takes before the job is first run. In this case, it is run immediately
require 'httparty'
require 'json'
require 'date'
pipedrive_api = ENV['PIPEDRIVE_API']

SCHEDULER.every '1m', :first_in => 0 do |job|
  root = "https://api.pipedrive.com/v1"
  d = Date.today << 5
  ye = format('%04d', d.year)
  m = format('%02d', d.month)
  body = "deals/timeline?start_date=#{ye}-#{m}-00&interval=month&amount=6&field_key=add_time&pipeline_id=1&exclude_deals=1"
  uri = "#{root}/#{body}&api_token=#{pipedrive_api}"
  response = HTTParty.get(uri)
  months = JSON.load(response.body)['data']
  dat = []
  value_data = []
  for i in [0,1,2,3,4,5]
    strx = months[i]['period_start']
    x = Date.strptime(strx,"%Y-%m-%d").to_time.to_i
    y = months[i]['totals']['count']
    temp = months[i]['totals']['values']
    if temp.empty?
      yv = 0
    else
      yv = temp['USD']
    end
    dat.push({x:x, y: y})
    value_data.push({x:x, y:yv})
    puts y
    puts yv
  end
  puts dat
  puts value_data

  send_event('month_value', points:value_data)
  send_event('month_count', points:dat)
end
