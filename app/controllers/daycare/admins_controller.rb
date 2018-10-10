class Daycare::AdminsController < Daycare::DaycaresController
  before_action :_add_daycare_admin_breadcrumb

  def balance_sheets
    @totals   = DaycareEntry.group( :student_id ).having( 'sum_total_time > 0' ).sum( :total_time )
    @students = Student.where( 'grade is not null' ).by_last_name

    render pdf:         'balance_sheets',
           disposition: 'attachment',
           margin:      {
             top:    5,
             bottom: 5,
             left:   5,
             right:  5,
           } # , show_as_html: true
  end

  def report
    # DaycareEntry.destroy_all
    params[:start_date] = current_date if params[:start_date].blank?
    params[:end_date]   = current_date if params[:end_date].blank?
    @entries            = DaycareEntry.joins( :student )
                            .includes( :student )
                            .where( 'checkin_date >= ? and checkin_date <= ?', params[:start_date], params[:end_date] )
                            .where( 'checkin_time is not null' )
                            .order( 'case when daycare_entries.checkout_time is NULL then 0 else 1 end' )
                            .by_student_last_name

    @breadcrumbs.push(
      {
        name: 'Report',
        url:  report_daycare_admin_url,
      },
    )
  end

  def show
    @page_header = 'Daycare admin'
    @page_title += ' - Daycare admin'
    @sections    = [
      {
        name:    'Balance due sheets (PDF)',
        url:     balance_sheets_daycare_admin_url,
        enabled: true,
      },
      {
        name:    'Daycare report',
        url:     report_daycare_admin_url,
        enabled: true,
      },
      {
        name:    'Entries',
        url:     daycare_admin_entries_url,
        enabled: true,
      },
      {
        name:    'Totals',
        url:     total_daycare_admin_url,
        enabled: true,
      },
    ]
    render 'shared/button_list'
  end

  def total
    @totals   = DaycareEntry.group( :student_id ).having( 'sum_total_time <> 0' ).sum( :total_time )
    @students = Student.where( 'grade is not null' ).by_last_name

    @breadcrumbs.push(
      {
        name: 'Totals',
        url:  total_daycare_admin_url,
      },
    )
  end

  private

    def _add_daycare_admin_breadcrumb
      @breadcrumbs.push(
        {
          name: 'Admin',
          url:  daycare_admin_url,
        },
      )
    end
end
