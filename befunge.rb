class Befunge

  def initialize(code)
    @playfield = build_field(code)    # convert the program into a 2d array
    @stack = []                       # the stack
    @dflow = ">"                      # direction flow of the program.
    @current_inst = [0, 0]            # (x, y) of current instruction
    @string_mode = false              # string mode toggle
  end

  def run
    while @playfield[@current_inst[0], @current_inst[1]] != "@"
      inst = intify @playfield[@current_inst[0]][@current_inst[1]] # magic
      #puts "inst is a #{inst.class}"

      if inst == '"'
        @string_mode = !@string_mode
      elsif @string_mode
        @stack.push(inst.ord)

      elsif inst.is_a? Integer
        @stack.push(inst)

      elsif ['>', '<', '^', 'v'].include? inst
        @dflow = inst

      elsif ['+', '-', '*', '/'].include? inst
        a = @stack.pop
        b = @stack.pop
        
        case inst
        when '+' then @stack.push(b+a)
        when '-' then @stack.push(b-a)
        when '*' then @stack.push(b*a)
        when '/' then @stack.push(b/a)
        when '%' then @stack.push(b%a)
        end

      elsif [',', '.'].include? inst
        a = @stack.pop

        case inst
        when ',' then print a.chr
        when '.' then print a
        end

      elsif ['_', '|'].include? inst
        a = @stack.pop

        case inst
        when '_' then if a == 0 then @dflow = '>' else @dflow = '<' end
        when '|' then if a == 0 then @dflow = 'v' else @dflow = '^' end
        end
      
      elsif ['@', '#'].include? inst
        case inst
        when '#'
          case @dflow
          when '>' then go_right
          when '<' then go_left
          when 'v' then go_down
          when '^' then go_up
          end
        when '@'
          return
        end

      elsif [':', "\\"]
        a = @stack.pop

        case inst
        when ':' then 2.times { @stack.push(a) }
        when "\\"
          b = @stack.pop
          @stack.push(a)
          @stack.push(b)
        end

      elsif ['p', 'g'].include? inst
        y = @stack.pop
        x = @stack.pop

        case inst
        when 'p'
        when 'g'
        end
      end

      case @dflow
      when '>' then go_right
      when '<' then go_left
      when 'v' then go_down
      when '^' then go_up
      end

    end
  end

  def print_debug()
    print "PLAYFIELD:"
    p @playfield
    print "STACK: "
    p @stack
    puts "LAST EXECUTED: #{@playfield[@current_inst[0]][@current_inst[1]]}"
    puts ""
    exit
  end

  private

  def build_field(code)
    code.split("\n").map(&:chars)
  end

  def intify(val) # TODO: There must be a better way to do this
    return 0 if val == "0"
    if val.to_i != 0
      return val.to_i
    end
    return val
  end

  # functions for code flow

  def go_right
    @current_inst[1] += 1
  end

  def go_left
    @current_inst[1] -= 1
  end

  def go_up
    @current_inst[0] -= 1
  end

  def go_down
    @current_inst[0] += 1
  end

  def go_random
    raise "Not implemented yet"
  end
end

bf = Befunge.new(File.read(ARGV[0]))
trap("SIGINT") do print_debug end

bf.run
