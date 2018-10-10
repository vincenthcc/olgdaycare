class DaycareEntryDate3 < ActiveRecord::Migration[5.1]
  def change

    remove_column :daycare_entries, :checking_date
    remove_column :daycare_entries, :chinkin_date
    add_column  :daycare_entries, :checkin_date, :string

  end
end
