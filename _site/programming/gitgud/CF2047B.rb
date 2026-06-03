def solve(fs) 
    n = fs.int
    str = fs.str
    char, count = str.chars.tally.max_by { |c, v| v }
    replace, _ = str.chars.tally.reject { |c, v| c == char } 
                                .min_by { |c, v| v } 
    if count < n
        str.sub!(replace, char)
    end
    puts str
end

def main
    fs = FastScanner.new
    t = fs.int
    t.times { solve(fs) }
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
        num = 0
        while (c = data.getbyte(idx)) && c > 32
            num = num * 10 + c - 48
            idx += 1
        end
        @idx = idx
        num
    end

    def ints(n)
        Array.new(n) { int }
    end
end

main