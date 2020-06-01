# frozen_string_literal: true

class Tutor < ApplicationRecord
  has_many :appointments, dependent: :destroy

  validates_presence_of :name, :email, :subject, :about
end
