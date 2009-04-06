class TestController < ApplicationController
  layout 'blog'

#   def index
#     render :text => "Hello world! Current date and time is: #{Time.now}"
#   end
  
#   def foo
#     @blarg = Time.now
#   end
  
#   def ruby
#     if request.post?
#       @query = params[:query]
#       begin 
#         @result = Object.new.instance_eval(@query)
#       rescue Exception => e
#         @result = e
#       end
#     end
#   end
  
#   def run_tests
#     require 'yak_test'
#     render :text => YAKTest.run_tests(params[:yak])
#     headers['Content-type'] = 'text/plain'
#   end
end
