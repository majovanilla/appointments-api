# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Appointment, type: :model do
  it { should belong_to(:tutor) }
  it { should validate_presence_of(:date) }
  it { should validate_presence_of(:location) }
end
