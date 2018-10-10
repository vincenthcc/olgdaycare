class Admin::FamiliesController < Admin::AdminController
  before_action :family, only: [ :destroy, :edit, :update ]
  before_action :_add_admin_families_breadcrumb

  def create
    @family = Family.create( family_params )
    if @family.persisted?
      redirect_to new_admin_family_url, notice: 'Family created!' and return if params[:another]

      redirect_to edit_admin_family_url( @family ), notice: 'Family created!'
    else
      flash[:alert] = @family.errors.full_messages
      new
    end
  end

  def destroy
    if @family.destroy
      redirect_to admin_families_url, notice: 'Family deleted!'
    else
      flash[:alert] = @family.errors.full_messages
    end
  end

  def edit
    @breadcrumbs.push(
      {
        name: "#{ @family.last_name } family",
        url:  admin_family_url( @family ),
      },
    )

    _family_form
  end

  def index
    @families = Family.order( :last_name )
  end

  def new
    @family = Family.new

    @breadcrumbs.push(
      {
        name: 'New family',
        url:  new_admin_family_url,
      },
    )

    _family_form
  end

  def update
    if @family.update( family_params )
      redirect_to edit_admin_family_url( @family ), notice: 'Family updated!'
    else
      flash[:alert] = @family.errors.full_messages
      new
    end
  end

  private

    def _add_admin_families_breadcrumb
      @breadcrumbs.push(
        {
          name: 'Families',
          url:  admin_families_url,
        },
      )
    end

    def family
      @family = Family.find( params[:id] )
      redirect_to admin_families_url, alert: 'Family not found' and return if @family.nil?
    end

    def _family_form
      @family_no  = []
      @family_yes = []
      Student.active.each do |student|
        next if @family.students.include?( student )

        if student.families.empty?
          @family_no.push( student )
        else
          @family_yes.push( student )
        end
      end

      render :form
    end

    def family_params
      params.require( :family ).permit( :last_name, :parents, :email, student_ids: [] )
    end
end
