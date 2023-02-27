require_relative 'spec_helper'

describe Carnival do
  before(:each) do
    @carnival = Carnival.new(7)
    @ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
    @ride2 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })
    @ride3 = Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })
    @visitor1 = Visitor.new('Bruce', 54, '$10')
    @visitor2 = Visitor.new('Tucker', 36, '$5')
    @visitor3 = Visitor.new('Penny', 64, '$15')
    @visitor1.add_preference(:gentle)
    @visitor2.add_preference(:gentle)
    @visitor2.add_preference(:thrilling)
    @visitor3.add_preference(:thrilling)
  end

  describe '#initialize' do
    it 'exists' do
      expect(@carnival).to be_a Carnival
    end

    it 'has a duration stored as an integer that represents days' do
      expect(@carnival.duration).to eq(7)
    end

    it 'has a list of rides that starts as empty by default' do
      expect(@carnival.rides).to eq([])
    end
  end
end