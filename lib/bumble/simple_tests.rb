
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
  
  test do 
    t1, t2, t3 = TestBumbleTwo.new, TestBumbleTwo.new, TestBumbleTwo.new
    begin 
      t1.save!
      t2.save!
      t3.save!
      k1, k2, k3 = t1.key, t2.key, t3.key
      
      eq TestBumbleTwo.all.map { |tt| tt.key }.sort, [k1,k2,k3].sort
    ensure 
      begin 
        TestBumbleTwo.all.each do |ee|
          ee.delete!
        end
      rescue Exception => e
        $servlet_context.log(e.inspect)
      end
    end
  end
end
