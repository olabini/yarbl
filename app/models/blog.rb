class Blog
  include Bumble

  ds :name, :owner_id, :created_at

  def owner
    if self.owner_id
      Person.get(self.owner_id)
    else
      nil
    end
  end

  def owner=(person)
    self.owner_id = person.key
  end
  
  def posts
    []
  end
end
