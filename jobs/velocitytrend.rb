#require 'json'
#require_relative '../lib/v1velocitytrend.rb'

SCHEDULER.every '1m', first_in: 0 do |job|
  #v1velocitytrend = V1VelocityTrend.new
  #data = v1velocitytrend.GetVelocityTrend("Scope:1093","",3)
  datax = [{x:1, y: 5}, {x:2, y:2}, {x:3, y:9}]
  #datax = JSON.parse(data)
  send_event('velocitytrend', points: datax)
end
