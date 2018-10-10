class Daycare::CheckinsController < Daycare::DaycaresController
  before_action :_add_daycare_checkin_breadcrumb

  def show
    @page_header = 'Daycare'
    @page_title += ' - Daycare'
    @sections    = []

    Current.grade_list.each do |grade|
      @sections.push(
        {
          name:    grade,
          url:     daycare_checkin_grade_url( grade ),
          enabled: true,
        },
      )
    end

    render 'shared/button_list'
  end

  private

    def _add_daycare_checkin_breadcrumb
      @breadcrumbs.push(
        {
          name: 'Check in',
          url:  daycare_checkin_url,
        },
      )
    end
end
