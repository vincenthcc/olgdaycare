class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :database_authenticatable, :confirmable, :lockable and :omniauthable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  devise :timeoutable

  default_scope{ where( allow_access?: true ).order( :first_name, :last_name ) }

  def full_name
    "#{ first_name } #{ last_name }".strip
  end
end
