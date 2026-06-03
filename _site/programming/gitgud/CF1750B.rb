def solve(fs) 
    n = fs.int
    str = fs.str

    ans = 0; zero = 0; one = 0;
    str.chars.chunk { |ch| ch == "1" }
            .each { |num, arr| 
                ans = [ans, arr.size * arr.size].max;
                if num then one += arr.size;
                else zero += arr.size
                end
            }
    ans = [ans, zero * one].max
    puts ans
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