class TestController < ActionController::Base
  def index
    render :text => "Hello world! Current date and time is: #{Time.now}"
  end
  
  def foo
    @blarg = Time.now
  end
end
