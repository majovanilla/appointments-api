# frozen_string_literal: true

class DeleteTimeFromAppointments < ActiveRecord::Migration[6.0]
  def change
    remove_column :appointments, :time
  end
end
