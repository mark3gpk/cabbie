class CreateDrivers < ActiveRecord::Migration[6.0]
  def change
    create_table :drivers do |t|
      t.string :name, null: false
      t.string :email, null: false, unique: true
      t.integer :phone_number, null: false, unique: true
      t.string :license_number, null: false, unique: true
      t.string :car_number, null: false, unique: true
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
