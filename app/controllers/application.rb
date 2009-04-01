# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

require 'beeu'

class ApplicationController < ActionController::Base
  layout 'blog'
  helper :all # include all helpers, all the time
  include BeeU

  before_filter :assign_user
  before_filter :assign_admin_status
  before_filter :assign_person
  
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
#  protect_from_forgery :secret => 'a1f3524526e38614030fe844529da315'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  protected
  def assign_person
    if @user
      @person = Person.find(:email => @user.email)
      unless @person 
        p = Person.new
        p.email = @user.email
        p.sur_name = @user.nickname
        p.save!
        @person = p
      end
    end
  end
end
