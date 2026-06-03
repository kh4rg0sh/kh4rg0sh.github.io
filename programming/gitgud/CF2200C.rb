def solve(fs) 
    n = fs.int
    str = fs.str

    valid = true
    stack = []
    str.chars
        .each { |c| 
            if stack.empty? then
                stack << c
            else
                if stack.last == c then 
                    stack.pop
                else 
                    stack << c
                end
            end
        }
    
    puts stack.empty? ? "YES" : "NO"
end

def main
    fs = FastScanner.new
    t = fs.int
    t.times { solve(fs) }
end

def sorted?(arr)
    arr.each_cons(2).all? { |a, b| a <= b }
end

def rsorted?(arr)
    arr.each_cons(2).all? { |a, b| a >= b }
end

class FastScanner
    def initialize
        @data = STDIN.read; @idx = 0
    end

    def str
        data = @data; idx = @idx
        idx += 1 while (c = data.getbyte(idx)) && c <= 32
        start = idx
        idx += 1 while (c = data.getbyte(idx)) && c > 32
        @idx = idx
        data[start...idx]
    end

    def int
        data = @data; idx = @idx
        idx += 1 while (c = data.getbyte(idx)) && c <= 32
        sign = 1
        if (c = data.getbyte(idx)) == 45
            sign = -1
            idx += 1
        elsif c == 43
            idx += 1
        end
        num = 0
        while (c = data.getbyte(idx)) && c >= 48 && c <= 57
            num = num * 10 + c - 48
            idx += 1
        end
        @idx = idx
        sign * num
    end

    def ints(n)
        Array.new(n) { int }
    end
end

main