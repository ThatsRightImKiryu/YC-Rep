# frozen_string_literal: false

# Контроллер сессии - время между "пользователь вошел" и "вышел"
class SessionController < ApplicationController
  skip_before_action :require_login, only: %i[login create]
  skip_before_action :check_user

  def login; end

  def create
    if (user = User.find_by_username(params[:username]))
      if user&.authenticate(params[:password])
        sign_in user
        redirect_to user_url(id: user)
      else
        redirect_to session_login_url, notice: t('invalid_password')
      end
    else
      redirect_to session_login_url, notice: t('invalid_username')
    end
  end

  def logout
    sign_out
    redirect_to session_login_url
  end
end
