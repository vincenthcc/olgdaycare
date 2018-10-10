class TardyController < ApplicationController
  def grades
    @grades = Student.grade_list()
  end

  def letters
    @letters = Student.grade_letter_list( params[:grade] )
  end

  def students
    @students = Student.grade_student_by_letter_list( params[:grade], params[:letter] )
  end

  def student
    @student = Student.find( params[:student] )
  end
end
