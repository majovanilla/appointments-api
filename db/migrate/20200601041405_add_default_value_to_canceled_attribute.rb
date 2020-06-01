# frozen_string_literal: true

class AddDefaultValueToCanceledAttribute < ActiveRecord::Migration[6.0]
  def change
    change_column_default :appointments, :canceled, false
  end
end
