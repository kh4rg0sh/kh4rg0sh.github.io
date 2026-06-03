def solve(fs) 
    str = fs.str
    n = str.size

    i = 0
    while i < n do
        if str[i] == "1" then
            if i + 1 < n && str[i + 1] == "?" then 
                j = i + 1
                while j < n && str[j] == "?" do 
                    j += 1
                end

                i += 1
                while i < j do
                    if j == n || str[j] == "1" then
                        str[i] = "1"
                    else
                        str[i] = "0"
                    end
                    i += 1
                end
        
            end
        elsif str[i] == "?" then
            str[i] = "0"
        end
        i += 1
    end
    
    puts str
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