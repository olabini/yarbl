class BlogsController < ActionController::Base
  def index
    @blogs = Blog.all
  end
  
  def blog
  end
  
  def post
  end
end
