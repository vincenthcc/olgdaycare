class DaycareEntryArchive < ActiveRecord::Migration[5.2]
  def change

    add_column :daycare_entries, :archive, :string

  end
end
