class Daycare::EntriesController < Daycare::AdminsController
  before_action :_add_daycare_admin_entries_breadcrumb
  before_action :_entry, only: [ :edit, :update ]

  def edit
    @breadcrumbs.push(
      {
        name: 'Entry edit',
        url:  daycare_admin_entry_url( @entry ),
      },
    )

    render :payment if ( @entry.total_time || 0 ).negative?
  end

  def index
    @page_title    += ' - Daycare entries'
    params[:page] ||= 1

    @entries = DaycareEntry.includes( :student ).order( updated_at: :desc ).page( params[:page] )
  end

  def update
    if params[:payment].present?
      params[:daycare_entry][:total_time] = params[:daycare_entry][:total_time].to_f / Current.daycare_per_hour * -1

      @entry.update( params.require( :daycare_entry ).permit( :total_time ) )

      redirect_to edit_daycare_admin_entry_url( @entry ), notice: 'Payment updated!'
    elsif params[:delete].present?
      @entry.destroy

      redirect_to daycare_admin_entries_url, notice: 'Entry deleted!'
    elsif params[:undo_checkout].present?
      @entry.update( checked_out_by: nil, checkout_time: nil, total_time: nil )

      redirect_to edit_daycare_admin_entry_url( @entry ), notice: 'Checkout undone!'
    else
      params[:daycare_entry][:checkin_time]  = Time.zone.parse( params[:daycare_entry][:checkin_time] ) - 8.hours if params[:daycare_entry][:checkin_time].present?
      params[:daycare_entry][:checkout_time] = Time.zone.parse( params[:daycare_entry][:checkout_time] ) - 8.hours if params[:daycare_entry][:checkout_time].present?

      if @entry.update( params.require( :daycare_entry ).permit( :checkin_time, :checked_out_by, :checkout_time ) )
        redirect_to edit_daycare_admin_entry_url( @entry ), notice: 'Entry updated!'
      else
        flash[:alert] = @entry.errors.full_messages
        edit
        render :edit
      end
    end
  end

  private

    def _add_daycare_admin_entries_breadcrumb
      @breadcrumbs.push(
        {
          name: 'Entries',
          url:  daycare_admin_entries_url,
        },
      )
    end

    def _entry
      @entry = DaycareEntry.find( params[:id] )
      redirect_to daycare_admin_entries_url, alert: 'Entry not found' and return if @entry.nil?
    end
end
