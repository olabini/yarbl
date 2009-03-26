
# minimalistic yak shaving test framework
# the purpose is to allow tests to be run on the GAE servers using a controller action
# the result will be text that either says everything is fine - or a description of the problems
# since the actual environment can't be duplicated locally, this seems
# like it's the best way to unit test stuff.
# The framework will load all tests from files in lib ending with _test.rb.

module YAKTest
  class TestOutput
    def initialize(str)
      @str = str
      @count = 0
    end
    
    def string
      @str
    end

    def -(line)
      @str << "\n-- #{line}\n"
      @count = 0
    end

    def success
      if @count > 80
        @str << "\n"
        @count = 0
      end
      @str << "."
      @count += 1
    end
    
    def failure(f, tst)
      @str << "\nFailure: #{f}\n"
      filter_trace(f.backtrace[1..-1]).each do |tr|
        @str << " #{tr}\n"
      end
      @str << "\n"
      @count = 0
    end

    def error(e, tst)
      @str << "\nError: #{e}\n"
      filter_trace(e.backtrace).each do |tr|
        @str << " #{tr}\n"
      end
      @str << "\n"
      @count = 0
    end
    
    private
    def filter_trace(arr_of_trace)
      new_arr = []
      arr_of_trace.each do |arr|
        if arr =~ /lib\/yak_test.rb/
          break
        end
        new_arr << arr
      end
      new_arr
    end
  end

  class Failure < Exception
    def initialize(name, *args)
      @name = name
      @args = args
    end
    
    def to_s
      "#@name #{@args.join(", ")}"
    end
  end
  
  class TestContext
    def initialize(group, output)
      @__test_group = group
      @__test_output = output
    end

    def __run_test(tst)
      begin 
        instance_eval(&tst)
        @__test_output.success
      rescue Failure => f
        @__test_output.failure(f, tst)
      rescue Exception => e
        @__test_output.error(e, tst)
      end
    end

    def eq(one, two)
      unless one == two
        raise Failure.new("eq", one, two)
      end
    end

    def neq(one, two)
      unless one != two
        raise Failure.new("neq", one, two)
      end
    end

    def ok(val = nil, &block)
      if block
        val = block.call
      end
      unless val
        raise Failure.new("ok", val)
      end
    end
  end
  
  class TestGroup
    def initialize(name)
      @name = name
      @tests = []
    end

    def test(&blk)
      @tests << blk
    end
    
    def run_tests(output)
      output - @name
      @tests.each do |tst|
        TestContext.new(self, output).__run_test(tst)
      end
    end
  end

  class << self
    def add_group(grp)
      @groups ||= []
      @groups << grp
    end

    def tests(name = nil, &blk)
      unless name
        name = eval("__FILE__", blk)
        base = File.dirname(__FILE__)
        if name =~ /#{base}\//
            name["#{base}/"] = ""
        end
      end
      tg = TestGroup.new(name)
      tg.instance_eval(&blk)
      add_group(tg)
    end
    
    def run_tests(params)
      unless defined?(@has_already_loaded)
        Dir["#{File.dirname(__FILE__)}/**/*_test{.rb,s.rb}"].each do |f|
          $stderr.puts "loading test file: #{f}"
          require f
        end
        
        @has_already_loaded = true
      end
      
      result = "No tests defined"
      if defined?(@groups)
        outp = TestOutput.new("")
        @groups.each do |tg|
          tg.run_tests(outp)
        end
        result = outp.string
      end
      result
    end
  end
end

