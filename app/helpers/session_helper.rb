# frozen_string_literal: false

# Its a very good helper
module SessionHelper
  def sign_in(user)
    cookies.signed[:user_id] = { value: user.id, expires: 7.days }
    @current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    cookies.signed[:user_id] = nil
    @current_user = nil
  end

  def current_user
    @current_user ||= User.find_by(id: cookies.signed[:user_id])
  end
  
end
