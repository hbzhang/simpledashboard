require 'json'
require 'oj'
#require 'mathn'


walkup = 0
checked_in = 0
checked_in_first_day =0
checked_in_percent = 0
checked_in_percent = 0

Dashing.scheduler.every '3s' do
  #last_valuation = current_valuation
  #current_valuation = rand(100)

  #APIKEY = 'qFuWyb9A1pIkykQ'
  #@SERVERURL = 'http://nightwing.recsports.vt.edu:3001/api?api_key=' + APIKEY

  #data = HTTParty.get @SERVERURL 

  @STATURL = 'http://nightwing.recsports.vt.edu:3001/api/stats?key=123456'

  #puts  @STATURL

  @stats = HTTParty.get(@STATURL)

  #@statshash = Oj.dump(@stats.body)

  @statshash  = JSON.parse(@stats.body)

  #puts @statshash 
  total_registrations = @statshash['stats']['total_registrations']
  walkup = @statshash['stats']['walkup']
  checked_in = @statshash['stats']['checked_in']
  checked_in_first_day = @statshash['stats']['checked_in_first_day']
  #checked_in_percent = checked_in.fdiv(@total_registrations)*100
  #checked_in_percent = checked_in_percent.round

  #puts total_registrations
  #puts walkup
  #puts checked_in
  #puts checked_in_percent

  #json = Oj.load(@statshash)
  #@statshash = JSON.parse(@stats.stats) 

  
  Dashing.send_event('totalregisters', { current:total_registrations})
  Dashing.send_event('walk', { current: walkup, last: walkup })
  Dashing.send_event('checkedin',   { value: checked_in })
  Dashing.send_event('checkedinfirstday',   { current: checked_in_first_day, last: checked_in_first_day })
  

end
