class Blog
  include Bumble

  ds :name, :owner_id, :created_at

  def owner
  end

  def owner=(person)
  end
  
  def posts
  end
end
