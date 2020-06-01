class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
      t.datetime :date
      t.string :location
      t.references :tutor, null: false, foreign_key: true
      t.boolean :canceled

      t.timestamps
    end
  end
end
