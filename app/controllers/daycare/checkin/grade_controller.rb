class Daycare::Checkin::GradeController < Daycare::CheckinsController
  def destroy
    DaycareEntry.checked_in( current_date, params[:id] ).where( student_id: params[:student_id] ).destroy_all

    head :no_content
  end

  def show
    @students   = Student.grade_student_list( params[:id] )
    @checked_in = DaycareEntry.checked_in( current_date, params[:id] ).pluck( :student_id )
  end

  def update
    params[:student] ||= { id: [] }
    ( params[:student][:id] || [] ).each do |id|
      DaycareEntry.create( student_id: id, teacher: Current.user, checkin_date: current_date, checkin_time: Time.zone.now.strftime( '2000-01-01 %H:%M -00:00' ) ) if DaycareEntry.checked_in( current_date ).where( student_id: id ).empty?
    end

    if last_grade?( params[:id] )
      redirect_to report_daycare_admin_url
    else
      idx = Current.grade_list.index( params[:id] ) + 1

      redirect_to daycare_checkin_grade_url( Current.grade_list[idx] )
    end
  end

  private

    def last_grade?( grade )
      Current.grade_list.last == grade
    end
end
