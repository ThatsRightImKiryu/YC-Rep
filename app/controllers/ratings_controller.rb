# frozen_string_literal: false

# Docs
class RatingsController < ApplicationController
  skip_before_action :require_login
  before_action :set_rating, except: %i[new]
  before_action :set_params, only: %i[new destroy]

  def new
    @rating = Rating.new(rating_params)
    if @rating.save
      redirect_to user_writing_url(@user, @writing)
    else
      redirect_to root_path
    end
  end

  def destroy
    @rating.destroy
    redirect_to user_writing_url(@user, @writing)
  end

  private

  def rating_params
    params[:commentator] = current_user.username
    params.permit(:rate, :comment, :writing_id, :commentator)
  end

  def set_rating
    @rating = Rating.find(params[:id])
  end

  def set_params
    get_user(params[:user_id])
    get_writing(@user.id, params[:writing_id])
  end
end
