class TestController < ActionController::Base
  def index
    render :text => "Hello world! Current date and time is: #{Time.now}"
  end
end
