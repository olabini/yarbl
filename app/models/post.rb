class Post
  include Bumble

  ds :title, :content, :created_at, :blog_id

  def blog=(b)
  end

  def blog
  end
end
