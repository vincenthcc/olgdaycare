class Families < ActiveRecord::Migration[5.2]
  def change

    create_table :families do |t|
      t.string :last_name
      t.string :parents
      t.string :email

      t.timestamps
    end

    create_join_table :families, :students do |t|
      t.index [ :family_id, :student_id ]
      t.index [ :student_id, :family_id ]
    end

    add_reference :daycare_entries, :family

  end
end
