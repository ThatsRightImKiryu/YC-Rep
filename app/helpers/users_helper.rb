module UsersHelper
  def admin?
    @current_user.role == 'admin'
  end

  def get_user(id)
    @user = User.find(id)
  end
end
