class AddDaycareTable < ActiveRecord::Migration[5.1]
  def change

    create_table :daycare_entries do |t|
      t.integer :student_id
      t.integer :teacher_id

      t.datetime :checked_in
      t.datetime :checked_out
      t.string :checked_out_by

      t.timestamps
    end
  end
end
