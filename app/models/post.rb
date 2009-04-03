class Post
  include Bumble

  ds :title, :content, :created_at, :blog_id
  belongs_to :blog, Blog
end
