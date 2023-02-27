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

  describe '#add_ride' do
    it 'can add multiple rides to the carnivals list of rides' do
      expect(@carnival.rides.empty?).to be true

      @carnival.add_ride(@ride1)
      @carnival.add_ride(@ride2)
      @carnival.add_ride(@ride3)

      expect(@carnival.rides).to eq([@ride1, @ride2, @ride3])
      expect(@carnival.rides.count).to eq(3)
    end
  end

  describe '#most_popular_ride' do
    it 'returns the ride object for the ride that has been ridden the most times' do
      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor1)

      @ride2.board_rider(@visitor1)
      @ride2.board_rider(@visitor2)

      @ride3.board_rider(@visitor3)

      expect(@carnival.most_popular_ride).to eq(@ride1)
    end
  end
end