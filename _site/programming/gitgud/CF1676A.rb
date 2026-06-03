def main
    t = int
    t.times { solve }
end

def solve
    digits = str_arr.map(&:to_i)
    first = digits[0, 3].sum
    last = digits[3, 3].sum
    puts first == last ? "YES" : "NO"
end

def int; gets.to_i end
def str; gets.chomp end
def str_arr; gets.chomp.chars end

main