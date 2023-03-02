# frozen_string_literal: false

# Docs
class PagesController < ApplicationController
  skip_before_action :check_user, only: %i[main index]
  before_action :set_page, only: %i[edit update destroy]
  before_action :set_page_with_number, only: %i[show]
  before_action :set_user_writing, only: %i[new show edit]
  # before_action :page_belongs_to, only: %i[destroy]

  def index
    @pages = Page.all
  end

  # GET /pages/1 or /pages/1.json
  def show; end

  # GET /pages/new
  def new
    @page = Page.new
  end

  # GET /pages/1/edit
  def edit; end

  # POST /pages or /pages.json
  def create
    respond_to do |format|
      if (@page = Page.new(page_params)).save

        format.html do
          redirect_to new_user_writing_page_url(@page),
                      notice: t('page_create')
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pages/1 or /pages/1.json
  def update
    respond_to do |format|
      if @page.update(page_params)
        format.html { redirect_to user_writing_page_url(@page), notice: t('page_update') }
        format.json { render :show, status: :ok, location: @page }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1 or /pages/1.json
  def destroy
    @page.destroy
    # params, Writing.find_by(params[:writing_id]), User.find(params[:user_id]),User.find(params[:user_id]).writings
    respond_to do |format|
      format.html do
        redirect_to user_writing_url(user_id: params[:user_id], id: @writing.id),
                    notice: t('page_destroy')
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_page
    @page = Page.find(params[:id])
  end

  def set_page_with_number
    @writing = Writing.find(params[:writing_id])
    @page = Page.find_by(id: params[:id], page_number: params[:page_number])
  end
  # Only allow a list of trusted parameters through.

  def page_params
    params[:text] = params[:page][:text]
    params.permit(:page_number, :text, :writing_id)
  end

  def set_user_writing
    get_user(params[:user_id])
    get_writing(@user.id, params[:writing_id])
  end
end
