class Admin::UsersController < Admin::AdminController
  def destroy
    user = User.unscope( :where ).find( params[:id] )
    redirect_to admin_users_url, alert: 'User not found!' if user.nil?

    user.update( allow_access?: !user.allow_access? )
    redirect_to admin_users_url, notice: 'User updated!'
  end

  def index
    @breadcrumbs.push(
      {
        name: 'Users',
        url:  admin_users_url,
      },
    )
  end

  def update
    user = User.unscope( :where ).find( params[:id] )
    redirect_to admin_users_url, alert: 'User not found!' if user.nil?

    case params[:type].downcase
      when 'admin'
        user.update( admin?: !user.admin? )
      else
        redirect_to admin_users_url, alert: 'Unknown type'
    end
    redirect_to admin_users_url, notice: 'User updated!'
  end
end
