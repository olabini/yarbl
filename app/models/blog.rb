class Blog
  include Bumble

  ds :name, :owner_id, :created_at
  belongs_to :owner, Person
  has_many :posts, :Post, :blog_id, :iorder => :created_at
end
