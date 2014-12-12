require 'jpush'

require 'test/unit'

class ReportFunctionTests < Test::Unit::TestCase
  AppKey = "e5c0d34f58732cf09b2d4d74"
  MasterSecret = "4cdda6d3c8b029941dbc5cb3"
  def setup
    @client = JPush::JPushClient.new(AppKey, MasterSecret)
  end
  
  def testgetReceivedsFixed
    result = @client.getReportReceiveds("1613113584,1229760629,1174658841,1174658641")
    puts result.toJSON
  end
  
  def testgetReceivedsFixed2
    result = @client.getReportReceiveds("1613113584,   ,1229760629,  ")
    puts result.toJSON
  end

  def testgetMessagesTest
     result = @client.getReportMessages("1613113584")
     puts result.toJSON
  end
  
  def testgetMessagesTest2
     result = @client.getReportMessages("1613113584,   ,1229760629,  ")
     puts result.toJSON
  end
  
  def testgetUsersTest
    result = @client.getReportUsers('MONTH', "2014-05", 1)
    puts result.toJSON
  end
  
  def testgetUserTest2
    result = @client.getReportUsers('DAY', "2014-05-10", 5)
    puts result.toJSON
  end
  
  def testgetUserTest3
    result = @client.getReportUsers('HOUR', "2014-05-10 06", 10)
    puts result.toJSON
  end

end
