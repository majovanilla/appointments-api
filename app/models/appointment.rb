# frozen_string_literal: true

class Appointment < ApplicationRecord
  belongs_to :tutor
  belongs_to :user

  validate :valid_date
  validates_presence_of :date, :location, :time, :tutor_id

  scope :ordered, -> { order(date: :asc) }
  scope :upcoming, ->(time) { ordered.where('date > ?', time) }

  def valid_date
    errors.add(:date, "can't be in the past") if date.present? && date < Date.today
  end
end
