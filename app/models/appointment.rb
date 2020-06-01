class Appointment < ApplicationRecord
  belongs_to :tutor

  validates_presence_of :date, :location
end
