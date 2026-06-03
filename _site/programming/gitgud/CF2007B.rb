def solve(fs) 
    n, m = fs.ints(2)
    arr = fs.ints(n)

    max = arr.max
    m.times do 
        c = fs.str; l, r = fs.ints(2)
        if max.between?(l, r) then
            max += 1 if c == "+"
            max -= 1 if c == "-"
        end
        print max, " "
    end
    puts "\n"
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