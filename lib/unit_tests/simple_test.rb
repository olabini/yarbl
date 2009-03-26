
require 'yak_test'

YAKTest.tests do 
  test do 
    eq 10, 5+5
  end

  test do 
    ok 10 == 5+5
  end

  test do 
    ok { 10 == 5+5 }
  end
  
#   # test a failure
#   test do 
#     neq 10, 5+5
#   end

#   # another failure
#   test do 
#     eq 9, 10
#   end
  
#   # an error
#   test do 
#     raise "blarg"
#   end
end
