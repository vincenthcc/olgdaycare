class DaycareTime < ActiveRecord::Migration[5.1]
  def change

    add_column :daycare_entries, :total_time, :float

  end
end
