# frozen_string_literal: true

class Appointment < ApplicationRecord
  belongs_to :tutor
  belongs_to :user

  validates_presence_of :date, :location, :time, :tutor_id
end
