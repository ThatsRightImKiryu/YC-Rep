# frozen_string_literal: false

# Docs
class WritingsController < ApplicationController
  skip_before_action :require_login, only: %i[main search]
  before_action :set_writing, except: %i[new create main index search]
  skip_before_action :check_user, only: %i[show new main index create search]

  def create
    respond_to do |format|
      if (@writing = (@user = current_user).writings.new(writing_params)).save
        format.html do
          redirect_to new_user_writing_page_url(page_number: 1, writing_id: @writing),
                      notice: I18n.t('new_writing')
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def new
    @writing = @current_user.writings.new
  end

  def update
    respond_to do |format|
      if @writing.update(writing_params)
        format.html { redirect_to user_writing_url(@user, @writing), notice: I18n.t('update_writing') }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @writing.destroy
    respond_to do |format|
      format.html do
        redirect_to user_writings_url(local: I18n.locale, user_id: @current_user.id),
                    notice: I18n.t('destroy_writing')
      end
    end
  end

  def show; end

  def search
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def main
    @writings = Writing.all
  end

  def edit; end

  def index; end

  private

  def set_writing
    @user = User.find(params[:user_id]) if params[:user_id]

    @writing = Writing.find(params[:id]) # if params[:id]&.match(/^\d$/)
  rescue StandardError
    redirect_to root_path
  end

  def writing_params
    params.require(:writing).permit(:name, :genre, :age_limit, :cover)
  end
end
