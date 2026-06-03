def solve(fs) 
    n, k = fs.ints(2)
    str = fs.str
    # puts n, k, str
    ans = 0; found = false
    str.chars.chunk { |n| n == "1" }
            .each { |num, arr|
                if num
                    found = true
                else
                    cnt = arr.size
                    cnt -= k if found
                    ans += cnt if cnt > 0
                end
            }
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