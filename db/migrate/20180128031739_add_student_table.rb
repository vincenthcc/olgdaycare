class AddStudentTable < ActiveRecord::Migration[5.1]
  def change

    create_table :students, id: false, primary_key: :student_id do |t|
      t.integer :student_id

      t.string :first_name
      t.string :middle_name
      t.string :last_name

      t.date :dob

      t.string :grade
      t.string :teacher

      t.timestamps
    end
  end
end
