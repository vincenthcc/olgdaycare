class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # before_action :authenticate_user!
  before_action :_pre

  include CommonFunctions

  private

    def _pre
      Current.action           = params[:action]
      Current.controller       = params[:controller]
      Current.daycare_per_hour = 4.00 # in dollars
      Current.domain           = request.server_name.downcase
      Current.grade_list       = [ 'TK', 'K', '1', '2', '3', '4', '5', '6', '7', '8' ]
      Current.user             = current_user if user_signed_in?

      cleanup = DaycareEntry.where( checkout_time: nil ).where( 'checkin_date < ?', current_date )
      cleanup.update( checkout_time: Time.new( 2000, 1, 1, 18, 0, 0, '-08:00' ), checked_out_by: 'System' )

      @page_title  = 'OLG intranet'
      @breadcrumbs = []
    end
end
