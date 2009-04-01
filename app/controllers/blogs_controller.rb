class BlogsController < ApplicationController
  layout 'blog'
  require_admin :new, :create
  
  def index
    @blogs = Blog.all
  end
  
  def blog
    @blog = Blog.get(params[:id].to_i)
  end
  
  def create
    name = params[:name]

    blog = Blog.new
    blog.name = name
    blog.owner = @person
    blog.save!

    redirect_to blogs_url
  end
end
