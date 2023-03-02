module FollowersHelper
  def follower?
    Follower.find_by(follow_id: @current_user.id, user_id: params[:id])
  end

  def followers_writings
    arr = []
    Follower.where(follow_id: current_user.id).each do |follower|
      arr << Writing.find_by(user_id: follower.user_id)
    end
    arr if arr[0]
  end

  def followers
    arr = []
    Follower.where(user_id: current_user.id).each do |follower|
      arr << User.find_by(id: follower.follow_id)
    end
    arr if arr[0]
  end

end
