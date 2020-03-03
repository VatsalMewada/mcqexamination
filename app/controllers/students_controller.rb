# frozen_string_literal: true

# controller for student related task
class StudentsController < ApplicationController
  before_action :set_student, only: %i[edit update destroy]
  def index; end

  def new
    @user = User.new
  end

  def create
    # byebug
    @user = User.new(info_params)
    @user.branch_id = params[:branch_id]
    if @user.save
      @user.add_role :student
      redirect_to new_student_path, notice: 'Student has been added!'
    else
      flash[:alert] = 'Something went wrong'
      render 'new'
    end
  end

  def destroy
    @user.destroy
    redirect_to new_faculty_path
  end

  def download_excel
    send_file(
      "#{Rails.root}/public/v1.csv",
      filename: 'add_student.csv',
      type: 'application/csv'
    )
  end

  private

  def info_params
    params.required(:user).permit(:enrollment, :sem, :branch_id, :status,
                                  :pyear, :password, :email, :fname, :lname,
                                  :mobile, :password_confirmation)
  end

  def set_student
    @user = User.find(params[:id])
  end
end