module JPushApiRubyClient
class Platform
  attr_accessor :android,:ios,:winphone;
  def initialize
    @android=false;
    @ios=false;
    @winphone=false;
  end
  def toJSON
    if @android==true&&@ios==true&&@winphone==true
      return 'all';
    else
      array=Array.new
      if @android==true then
        array.push('android')
      end
      if @ios==true then
        array.push('ios')
      end
      if @winphone==true then
        array.push('winphone')
      end
      return array;
    end
  end
end
end