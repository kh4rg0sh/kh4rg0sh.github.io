def main
    data = STDIN.read.split.map(&:to_i)

    t = data.shift
    t.times do
        n = data.shift; x = data.shift
        arr = data.shift(n)
        
        ans = [arr.first, 2 * (x - arr.last)].max
        arr.each_cons(2) do |x, y|
            ans = [ans, y - x].max
        end

        puts ans
    end
end

main