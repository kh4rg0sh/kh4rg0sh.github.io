def solve(fs)
    board = fs.lines(8)
    matrix = board.map(&:chars)
    
    for row in 1..7 do
        for col in 1..7 do
            if matrix[row][col] == "#" &&
                matrix[row - 1][col - 1] == "#" &&
                matrix[row + 1][col - 1] == "#" &&
                matrix[row - 1][col + 1] == "#" &&
                matrix[row + 1][col + 1] == "#"
                puts "#{row + 1} #{col + 1}"
                return
            end
        end
    end
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

    def lines(n)
        Array.new(n) { str }
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