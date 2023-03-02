module RatingsHelper
  def number_of_comments(user)
    count = 0
    user.writings.each do |w|
      count += w.ratings.count
    end
    count
  end
end
