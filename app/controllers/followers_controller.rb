# frozen_string_literal: false

# Docs
class FollowersController < ApplicationController
  def new
    @follower = Follower.new(user_id: params[:id], follow_id: @current_user.id)
    flash[:notice] = if @follower.save
                       t('following_done')
                     else
                       t('following_fail')
                     end
    redirect_to user_url(User.find(params[:id]))
  end

  def destroy
    @user = User.find_by(id: params[:user_id])
    @user.followers.find_by(user_id: params[:id], follow_id: @current_user.id).destroy
    redirect_to user_url(User.find(params[:id]))
  end
end
