# frozen_string_literal: true

class AddNewAttributesColumnsToTutors < ActiveRecord::Migration[6.0]
  def change
    add_column :tutors, :img, :string
    add_column :tutors, :rate, :string
    add_column :tutors, :experience, :string
  end
end
