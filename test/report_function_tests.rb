require 'jpush'

require 'test/unit'

class ReportFunctionTests < Test::Unit::TestCase
  AppKey = "7d431e42dfa6a6d693ac2d04"
  MasterSecret = "5e987ac6d2e04d95a9d8f0d1"
  def setup
    @client = JPush::JPushClient.new(AppKey, MasterSecret)
  end
  
  def testgetReceivedsFixed
    result = @client.getReportReceiveds("1613113584,1229760629,1174658841,1174658641")
  end
  
  def testgetReceivedsFixed2
    result = @client.getReportReceiveds("1613113584,   ,1229760629,  ")
  end
  
  def testgetMessagesTest
     result = @client.getReportMessages("1613113584")
  end
  
  def testgetMessagesTest2
     result = @client.getReportMessages("1613113584,   ,1229760629,  ")
  end
  
  def testgetUsersTest
    result = @client.getReportUsers('MONTH', "2014-05", 1)
  end
  
  def testgetUserTest2
    result = @client.getReportUsers('DAY', "2014-05-10", 5)
  end
  
  def getUserTest3
    result = @client.getReportUsers('HOUR', "2014-05-10 06", 10)
  end
end
