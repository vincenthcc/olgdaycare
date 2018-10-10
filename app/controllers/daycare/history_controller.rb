class Daycare::HistoryController < Daycare::DaycaresController
  def show
    @student = Student.find_by_student_id( params[:id] )
    redirect_to total_daycare_admin_url, alert: 'Student not found' and return if @student.nil?

    @history = DaycareEntry.where( student: @student )

    @breadcrumbs.push(
      {
        name: 'Admin',
        url:  daycare_admin_url,
      },
      {
        name: 'Totals',
        url:  total_daycare_admin_url,
      },
      {
        name: 'History',
        url:  daycare_admin_history_url,
      },
    )
  end
end
