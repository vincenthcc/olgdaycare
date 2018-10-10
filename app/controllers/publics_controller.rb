class PublicsController < ApplicationController
  before_action :_add_public_breadcrumb

  def show
    @page_header = 'OLG intranet'
    @sections    = [
      # {
      #   name:    'Daycare',
      #   enabled: true,
      #   url:     daycare_url,
      # },
      # {
      #   name: 'Tardy Sign In',
      #   enabled: false,
      #   url: tardy_url,
      # },
      # {
      #   name: 'Visitor Sign in',
      #   enabled: false,
      #   url: '#',
      # },
      # {
      #   name: 'Visitor Sign out',
      #   enabled: false,
      #   url: '#',
      # },
      # {
      #   name: 'Parent Volunteer log',
      #   enabled: false,
      #   url: '#',
      # },
      # {
      #   name: 'Student sign out/in log',
      #   enabled: false,
      #   url: '#',
      # },
      # {
      #   name: 'Absence form',
      #   enabled: false,
      #   url: '#',
      # },
    ]

    render 'shared/button_list'
  end

  private

    def _add_public_breadcrumb
      @breadcrumbs.push(
        {
          name: 'Public',
          url:  public_url,
        },
      )
    end
end
