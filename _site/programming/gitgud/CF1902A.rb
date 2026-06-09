class FastScanner
    def initialize
        @data = STDIN.read
        @idx = 0
    end

    def token
        data = @data
        idx = @idx

        idx += 1 while data.getbyte(idx) <= 32

        start = idx
        idx += 1 while (c = data.getbyte(idx)) > 32

        @idx = idx
        data[start...idx]
    end

    def int
        data = @data; idx = @idx

        idx += 1 while data.getbyte(idx) <= 32

        num = 0
        while (c = data.getbyte(idx)) > 32
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