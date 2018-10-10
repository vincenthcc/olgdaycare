class Daycare::CheckoutsController < Daycare::DaycaresController
  before_action :_add_daycare_checkout_breadcrumb

  # confirmation page
  def create
    @entries = DaycareEntry.includes( :student ).checked_in( current_date ).where( id: params[:id] ).by_student_last_name
  end

  # list currently signed in students
  def show
    @entries = DaycareEntry.includes( :student ).checked_in( current_date ).where( 'checkin_time is not null' ).by_student_last_name
  end

  # sign students out
  def update
    params[:entry].each do |p_entry|
      entry  = DaycareEntry.checked_in( current_date ).where( id: p_entry.last[:id] )
      family = nil # Family.find( p_entry.last[:family_id] )
      entry.update( checkout_time: Time.zone.now.strftime( '2000-01-01 %H:%M -00:00' ), checked_out_by: params[:checked_out_by], family: family )
    end

    redirect_to daycare_checkout_url
  end

  private

    def _add_daycare_checkout_breadcrumb
      @breadcrumbs.push(
        name: 'Check out',
        url:  daycare_checkout_url,
      )
    end
end
