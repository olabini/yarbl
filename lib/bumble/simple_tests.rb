
require 'yak_test'
require 'bumble'

class TestBumbleOne
  include Bumble

  ds :name, :age, :length
end

class TestBumbleTwo
  include Bumble
  
  ds :name, :address
end

YAKTest.tests do 
  test do 
    t1 = TestBumbleOne.new
    begin
      t1.name = "Foobarus"
      t1.save!

      k = t1.key

      t2 = TestBumbleOne.get(k)

      eq t2.name, "Foobarus"
    ensure
      begin 
        t1.delete!
      rescue Exception
      end
    end
  end
end
