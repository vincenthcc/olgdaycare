class DaycareEntryDate < ActiveRecord::Migration[5.1]
  def change

    remove_column :daycare_entries, :checkin_date

    add_column :daycare_entries, :checking_date, :string

  end
end
