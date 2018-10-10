class Daycare::PaymentsController < Daycare::DaycaresController
  def show
    @student = Student.find_by_student_id( params[:id] )
    redirect_to total_daycare_admin_url, alert: 'Student not found' and return if @student.nil?

    @current_due       = DaycareEntry.where( student: @student ).sum( :total_time )
    @previous_payments = DaycareEntry.where( student: @student ).where( 'total_time < 0' )

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
        name: 'Payments',
        url:  daycare_admin_payment_url,
      },
    )
  end

  def update
    @student = Student.find_by_student_id( params[:id] )
    redirect_to total_daycare_admin_url, alert: 'Student not found' and return if @student.nil?

    hours_paid = ( 0 - ( params[:amount].to_f / Current.daycare_per_hour ) )

    DaycareEntry.create( student: @student, checked_out_by: 'Payment', total_time: hours_paid )

    redirect_to daycare_admin_payment_url( @student.student_id )
  end
end
