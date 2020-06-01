# frozen_string_literal: true

class CreateTutors < ActiveRecord::Migration[6.0]
  def change
    create_table :tutors do |t|
      t.string :name
      t.string :email
      t.string :subject
      t.text :about

      t.timestamps
    end
  end
end
