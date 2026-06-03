def solve(fs) 
    l, r = fs.ints(2)
    arr = (l..r).to_a
    ans = 0; i = 0;
    while i + 2 < arr.size
        x, y, z = arr[i, 3]
        if x.odd?
            ans += 1
            i += 3
        else
            i += 1
        end
    end

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