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
      @carnival.add_ride(@ride1)
      @carnival.add_ride(@ride2)
      @carnival.add_ride(@ride3)

      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor1)

      @ride2.board_rider(@visitor1)
      @ride2.board_rider(@visitor2)

      @ride3.board_rider(@visitor3)

      expect(@carnival.most_popular_ride).to eq(@ride1)
    end
  end

  describe '#most_profitable_ride' do
    it 'returns the ride object for the ride that has the highest max revenue' do
      @carnival.add_ride(@ride1)
      @carnival.add_ride(@ride2)
      @carnival.add_ride(@ride3)

      @ride1.board_rider(@visitor1)
      @ride2.board_rider(@visitor1)
      @ride2.board_rider(@visitor2)
      @ride3.board_rider(@visitor3)

      expect(@ride1.total_revenue).to eq(1)
      expect(@ride2.total_revenue).to eq(10)
      expect(@ride3.total_revenue).to eq(2)

      expect(@carnival.most_profitable_ride).to eq(@ride2)
    end
  end

  describe '#total_ride_revenue' do
    it 'returns the total revenue from all rides at the carnival' do
      @carnival.add_ride(@ride1)
      @carnival.add_ride(@ride2)
      @carnival.add_ride(@ride3)

      2.times {@ride1.board_rider(@visitor1)}
      @ride2.board_rider(@visitor1)
      @ride2.board_rider(@visitor2)
      3.times {@ride3.board_rider(@visitor3)}

      expect(@carnival.total_ride_revenue).to eq(18)
    end
  end

  describe '#get_details' do
    it 'returns a hash with details about the carnival and its visitors and rides' do
      @carnival.add_ride(@ride1)
      @carnival.add_ride(@ride2)
      @carnival.add_ride(@ride3)

      2.times {@ride1.board_rider(@visitor1)}
      @ride2.board_rider(@visitor1)
      @ride2.board_rider(@visitor2)
      3.times {@ride3.board_rider(@visitor3)}

      expect(@carnival.get_details).to be_a Hash
      expect(@carnival.get_details.keys).to equal([:visitor_count, :revenue, :visitor_summary, :ride_summary])
      expect(@carnival.get_details[:visitor_count]).to eq(3)
      expect(@carnival.get_details[:revenue]).to eq(18)
      expect(@carnival.get_details[:visitor_summary]).to eq({@visitor1 => ['Carousel', 7],
                                                             @visitor2 => ['Ferris Wheel', 5],
                                                             @visitor3 => ['Roller Coaster', 6]})
      expect(@carnival.get_details[:ride_summary]).to eq({@ride1 => [[@visitor1], 2],
                                                          @ride2 => [[@visitor1, @visitor2], 10],
                                                          @ride3 => [[@visitor3], 6]})
    end
  end
end