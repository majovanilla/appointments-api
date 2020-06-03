# frozen_string_literal: true

class Tutor < ApplicationRecord
  has_many :appointments, dependent: :destroy

  validates_presence_of :name, :subject, :about
  validates :email, presence: true, uniqueness: true
end
