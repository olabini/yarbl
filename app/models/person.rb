class Person
  include Bumble

  ds :given_name, :sur_name, :email
  # has_many :blogs, Blog
end
