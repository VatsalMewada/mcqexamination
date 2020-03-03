# frozen_string_literal: true

# Faculty controller
class FacultiesController < ApplicationController
  before_action :set_faculty, only: %i[edit update destroy]
  def index; end

  def new
    @user = User.new
  end

  def edit; end

  def update
    # byebug
    if @user.update(info_params)
      redirect_to new_faculty_path, notice: 'Faculty updated Successfully'
    else
      render 'edit'
    end
  end

  def create
    @user = User.new(info_params)
    @user.branch_id = params[:branch_id]
    if @user.save
      @user.add_role :faculty
      redirect_to new_faculty_path, notice: 'Faculty has been added'
    else
      render 'new'
    end
  end

  def destroy
    @user.destroy
    redirect_to new_faculty_path
  end

  private

  def info_params
    params.required(:user).permit(:enrollment, :sem, :branch_id, :status,
                                  :pyear, :password, :email, :fname, :lname,
                                  :mobile, :password_confirmation)
  end

  def set_faculty
    @user = User.find(params[:id])
  end
end