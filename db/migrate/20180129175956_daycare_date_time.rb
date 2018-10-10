class DaycareDateTime < ActiveRecord::Migration[5.1]
  def change

    remove_column :daycare_entries, :checked_in
    remove_column :daycare_entries, :checked_out

    add_column :daycare_entries, :checkin_date, :date
    add_column :daycare_entries, :checkin_time, :time
    add_column :daycare_entries, :checkout_time, :time

    add_index :daycare_entries, :checkin_date

  end
end
