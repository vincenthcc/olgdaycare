class DaycareEntryDate2 < ActiveRecord::Migration[5.1]
  def change

    remove_column :daycare_entries, :chinking_date
    add_column  :daycare_entries, :chinkin_date, :string

  end
end
