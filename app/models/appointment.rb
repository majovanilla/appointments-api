class Appointment < ApplicationRecord
  belongs_to :tutor
  belongs_to :user

  validate :valid_date
  validates_presence_of :date, :location, :tutor_id

  scope :ordered, -> { order(date: :asc) }

  def valid_date
    errors.add(:date, "can't be in the past") if date.present? && date < Date.today
  end
end
