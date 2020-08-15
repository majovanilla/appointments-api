# frozen_string_literal: true

class AddUserColumnToAppointments < ActiveRecord::Migration[6.0]
  def change
    add_reference :appointments, :user, index: true
  end
end
