class UserVisible < ActiveRecord::Migration[5.2]
  def change

    add_column :users, :allow_access?, :boolean, default: true

  end
end
