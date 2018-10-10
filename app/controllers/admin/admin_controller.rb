class Admin::AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :_add_admin_breadcrumb
  before_action :_admin_check

  def show
    @sections = [
      {
        name:    'Families',
        url:     admin_families_url,
        enabled: true,
      },
      {
        name:    'Student list import',
        url:     admin_students_url,
        enabled: true,
      },
      {
        name:    'Users',
        url:     admin_users_url,
        enabled: true,
      },
      # {
      #   name:    '',
      #   url:     _url,
      #   enabled: true,
      # },
    ]

    render 'shared/button_list'
  end

  private

    def _add_admin_breadcrumb
      @breadcrumbs.push(
        {
          name: 'Admin',
          url:  admin_url,
        },
      )
    end

    def _admin_check
      redirect_to root_url, alert: 'You aren\'t allowed there' unless Current.user.admin?
    end
end
