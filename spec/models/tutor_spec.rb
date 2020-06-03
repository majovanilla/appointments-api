# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tutor, type: :model do
  it { should have_many(:appointments).dependent(:destroy) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:subject) }
  it { should validate_presence_of(:about) }
  it { should validate_uniqueness_of(:email) }
end
