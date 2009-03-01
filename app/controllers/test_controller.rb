class TestController < ActionController::Base
  def index
    render :text => "Hello world!"
  end
end
