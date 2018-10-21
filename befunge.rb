class Befunge

  CODE_DIRS = {
    right: {x: 1, y: 0},
    left: {x: -1, y: 0},
    down: {x: 0, y: 1},
    up: {x: 0, y: -1}
  }

  def initialize(code)
    @playfield = build_field(code)    # convert the program into a 2d array
    @stack = []                       # the stack

    @code_ptr = {x: 0, y: 0}          # (x, y) of current instruction
    @code_dir = CODE_DIRS[:right]     # direction flow of the program.
  end

  def run
    loop do
      inst = @playfield[@code_ptr[:y]][@code_ptr[:x]] # x and y inversion
      
      if ('0'..'9').include? inst
        @stack.push(inst.to_i)

      elsif ['+', '-', '/', '*', '%', '`'].include? inst
        a = @stack.pop
        b = @stack.pop

        @stack.push(
          case inst
          when '+' then b+a
          when '-' then b-a
          when '*' then b*a
          when '/' then b/a
          when '%' then b%a
          when '`' then b>a ? 1 : 0
          end 
        )
      
      elsif ['p', 'g'].include? inst
        y = @stack.pop
        x = @stack.pop

        # x and y inversion (again)
        case inst
        when 'p' then @playfield[y][x] = @stack.pop.chr
        when 'g' then @stack.push @playfield[y][x].ord
        end

      elsif ['!', ',', '.', '$'].include? inst
        a = @stack.pop

        case inst
        when '!' then @stack.push a == 0 ? 1 : 0
        when '.' then print a
        when ',' then print a.chr
        end

      elsif ['&', '~'].include? inst
        @stack.push inst == '&' ? STDIN.gets.chomp.to_i : STDIN.gets.chomp.ord

      elsif ['>', '<', '^', 'v', '?', '_', '|'].include? inst
        @code_dir = case inst
        when '>' then CODE_DIRS[:right]
        when '<' then CODE_DIRS[:left]
        when '^' then CODE_DIRS[:up]
        when 'v' then CODE_DIRS[:down]
        when '_' then @stack.pop == 0 ? CODE_DIRS[:right] : CODE_DIRS[:left]
        when '|' then @stack.pop == 0 ? CODE_DIRS[:down] : CODE_DIRS[:up]
        when '?' then CODE_DIRS[CODE_DIRS.keys.sample]
        end

      elsif inst == '"'
        move_ptr # skip the first quote

        loop do
          inst = @playfield[@code_ptr[:y]][@code_ptr[:x]]
          break if inst == '"'
          @stack.push(inst.ord)
          move_ptr
        end

      elsif inst == '#'
        move_ptr

      elsif inst == ':'
        @stack.push(@stack.empty? ? 0 : @stack.last)

      elsif inst == "\\"
        if @stack.size == 1
          @stack.push 0
        else
          @stack[-1], @stack[-2] = @stack[-2], @stack[-1]
        end

      elsif inst == '@'
        break
      end
      
      move_ptr
    end
  end

  private

  def build_field(code)
    code.split("\n").map(&:chars)
  end

  def move_ptr()
    @code_ptr[:x] += @code_dir[:x]
    @code_ptr[:y] += @code_dir[:y]
  end

end

def show_usage
  puts "USAGE: ruby befunge.rb <filename>"
end


if (ARGV.length == 0) or !File.file?(ARGV[0]) then show_usage; exit end

trap("SIGINT") do exit end

Befunge.new(File.read(ARGV[0])).run
