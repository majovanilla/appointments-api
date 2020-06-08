# frozen_string_literal: true

class ChangeDatimeOnAppointments < ActiveRecord::Migration[6.0]
  def change
    remove_column :appointments, :date
    add_column :appointments, :date, :date
    add_column :appointments, :time, :time
  end
end
