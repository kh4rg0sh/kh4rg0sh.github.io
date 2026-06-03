def solve(fs) 
    x, n = fs.ints(2)
    ans = x
    if x.abs % 2 == 0
        rem = n % 4
        if rem == 1 then
            ans = x - n
        elsif rem == 2 then 
            ans = x - (n - 1) + n
        elsif rem == 3 then
            ans = x - (n - 2) + (n - 1) + n
        end
    else 
        rem = n % 4
        if rem == 1 then 
            ans = x + n
        elsif rem == 2 then
            ans = x + (n - 1) - n
        elsif rem == 3 then 
            ans = x + (n - 2) - (n - 1) - n
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