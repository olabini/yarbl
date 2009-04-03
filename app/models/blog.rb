class Blog
  include Bumble

  ds :name, :owner_id, :created_at
  belongs_to :owner, Person
  #  has_many :posts, :Post, :iorder => :created_at

  def posts
    Post.all({:blog_id => self.key}, :iorder => :created_at)
  end
end
