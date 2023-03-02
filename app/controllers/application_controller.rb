# frozen_string_literal: false

# Docs
class ApplicationController < ActionController::Base
  include SessionHelper
  include UsersHelper
  include WritingsHelper
  include FollowersHelper
  include RatingsHelper

  before_action :require_login
  before_action :check_user

  def require_login
    redirect_to session_login_url, notice: I18n.t('login_please') unless signed_in?
  end
  before_action :set_locale

  def default_url_options
    { locale: I18n.locale }
  end

  def set_locale
    I18n.locale = extract_locale || I18n.default_locale
  end

  def extract_locale
    parsed_locale = params[:locale]
    parsed_locale.to_sym if I18n.available_locales.map(&:to_s).include?(parsed_locale)
  end

  def page_belongs_to
    @current_user.writings.find(params[:id])
  rescue StandardError
    redirect_to root_path
  end

  def writing_belongs_to
    @current_user.writings.find(params[:id])
  rescue StandardError
    redirect_to root_path
  end

  def check_user
    redirect_to '/404.html' if params[:user_id].to_i != @current_user.id && !admin?
  end
end
