class BlogsController < ApplicationController
  layout 'blog'
  require_admin :new_post, :create_post, :create, :remove, :remove_post

  def start
    @posts = Post.all({}, :limit => 15, :iorder => :created_at)
  end
  
  def index
    @blogs = Blog.all
  end
  
  def blog
    @blog = Blog.get(params[:id])
    @posts = @blog.posts
  end

  def post
    @post = Post.get(params[:post_id])
    @blog = @post.blog
  end
  
  def remove
    Blog.delete(params[:id])
    redirect_to blogs_url
  end
  
  def create
    name = params[:name]
    blog = Blog.create :name => name, :owner => @person, :created_at => Time.now

    redirect_to blogs_url
  end
  
  def new_post
    @blog = Blog.get(params[:id])
  end
  
  def create_post
    @blog = Blog.get(params[:id])
    Post.create :title => params[:title], :content => params[:content], :blog => @blog, :created_at => Time.now

    redirect_to blog_url(@blog)
  end

  def remove_post
    post = Post.get(params[:id])
    blog = post.blog
    post.delete!

    redirect_to blog_url(blog)
  end
end
