class CreatePatients < ActiveRecord::Migration[6.0]
  def change
    create_table :patients do |t|
      t.string :first_name
      t.string :last_name
      t.integer :age
      t.date :dob
      t.string :sex
      t.number :phone

      t.timestamps
    end
  end
end
