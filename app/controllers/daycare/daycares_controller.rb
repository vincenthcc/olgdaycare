class Daycare::DaycaresController < ApplicationController
  before_action :authenticate_user!
  before_action :_add_daycare_breadcrumb

  def show
    @page_header = 'Daycare'
    @page_title += ' - Daycare'
    @sections    = [
      {
        name:    'Admin',
        url:     daycare_admin_url,
        enabled: true,
      },
      {
        name:    'Check in',
        url:     daycare_checkin_url,
        enabled: true,
      },
      {
        name:    'Check out',
        url:     daycare_checkout_url,
        enabled: true,
      },
    ]
    render 'shared/button_list'
  end

  private

    def _add_daycare_breadcrumb
      @breadcrumbs.push(
        {
          name: 'Daycare',
          url:  daycare_url,
        },
      )
    end
end
