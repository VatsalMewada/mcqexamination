# frozen_string_literal: true

# Faculty controller
class FacultiesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_faculty, only: %i[edit update destroy]
  before_action :all_faculty, only: %i[edit new faculty_list]
  def new
    @faculty = User.new
  end

  def update
    # byebug
    if @faculty.update(faculty_params)
      redirect_to faculty_list_faculties_path, notice: 'Faculty updated Successfully'
    else
      render 'edit'
    end
  end

  def create
    @faculty = User.new(faculty_params)
    if @faculty.save(context: :faculty)
      @faculty.add_role :faculty
      redirect_to faculty_list_faculties_path, notice: 'Faculty has been added'
    else
      render 'new'
    end
  end

  def destroy
    @faculty.destroy
    redirect_to faculty_list_faculties_path
  end

  def faculty_list; end

  private

  def faculty_params
    params.required(:user).permit(:enrollment, :sem, :branch_id, :status,
                                  :pass_out_year, :password, :email, :fname, :lname,
                                  :mobile, :password_confirmation)
  end

  def find_faculty
    @faculty = User.find(params[:id])
  end

  def all_faculty
    @faculties = User.with_role :faculty
  end
end
