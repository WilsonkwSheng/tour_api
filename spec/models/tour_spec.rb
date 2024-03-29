require 'rails_helper'

RSpec.describe Tour, type: :model do
  it { should belong_to(:tour_host) }
  it { should validate_presence_of :title }
  it { should validate_presence_of :description }
  it { should validate_presence_of :region }
  it { should validate_presence_of :city }
  it { should validate_presence_of :travel_type }
end
