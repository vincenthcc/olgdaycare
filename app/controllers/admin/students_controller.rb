class Admin::StudentsController < Admin::AdminController
  before_action :_add_admin_students_breadcrumb

  def create
    @records = []

    params[:roster].read.split( "\n" )[4..-1].each do |rec|
      @records.push( rec[1..-3].split( /","/ ) )
    end
  end

  def show; end

  # update database
  def update
    Student.update_all( grade: nil, teacher: nil ) # rubocop:disable Rails/SkipsModelValidations

    params[:student].each do |_, student|
      s = Student.find_or_create_by( student_id: student[:student_id] )

      next if s.update(
        first_name:  student[:first_name],
        middle_name: student[:middle_name],
        last_name:   student[:last_name],
        dob:         student[:dob].present? ? Date.strptime( student[:dob], '%m/%d/%Y' ) : nil,
        grade:       student[:grade],
        teacher:     student[:teacher],
      )

      raise "Error updating student '#{ student.first_name } #{ student.last_name }'"
    end
  end

  private

    def _add_admin_students_breadcrumb
      @breadcrumbs.push(
        name: 'Students',
        url:  admin_students_url,
      )
    end
end
