str = gets[0..-2]
words = str.split
letters = str.split('').uniq.select { |l| l.match(/[aoiuey]/) }
letters = letters.select { |l| words.all? { |w| w.include?(l) } }
p letters
