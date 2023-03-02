str = gets
word_n = gets.to_i - 1
str = str.split.select { |w| (w.length % 2).zero? }
if str.empty?
  p 'В строке нет слов с четным количеством букв'
elsif word_n > str.size || !word_n.positive?
  p 'Слова с таким номером нет'
else
  p str[word_n]
end
