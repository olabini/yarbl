class TestController < ActionController::Base
  def index
    render :text => "Hello world! Current date and time is: #{Time.now}"
  end
  
  def foo
    @blarg = Time.now
  end
  
  def ruby
    if request.post?
      @query = params[:query]
      begin 
        @result = Object.new.instance_eval(@query)
      rescue Exception => e
        @result = e
      end
    end
  end
end
