class HomeController < ApplicationController
  def index
    @page_header = 'OLG intranet'
    @sections    = []
    @breadcrumbs.push(
      name: 'Home',
      url:  root_url,
    )

    if user_signed_in?
      if current_user.admin?
        @sections.push(
          name:    'Admin',
          enabled: true,
          url:     admin_url,
        )
      end

      @sections.push(
        name:    'Daycare',
        enabled: true,
        url:     daycare_url,
      )
    end

    render 'shared/button_list'
  end
end
