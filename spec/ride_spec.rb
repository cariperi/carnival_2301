require_relative 'spec_helper'

describe Ride do
  before(:each) do
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
      expect(@ride1).to be_a Ride
    end

    it 'has a name' do
      expect(@ride1.name).to eq('Carousel')
    end

    it 'has a minimum height' do
      expect(@ride1.min_height).to eq(24)
    end

    it 'has an admission fee' do
      expect(@ride1.admission_fee).to eq(1)
    end

    it 'has an excitement level' do
      expect(@ride1.excitement).to eq(:gentle)
    end

    it 'has a total revenue counter that starts at zero by default' do
      expect(@ride1.total_revenue).to eq(0)
    end

    it 'has a rider log that is empty by default' do
      expect(@ride1.rider_log).to eq({})
    end
  end

  describe '#board rider' do
    it 'allows visitors to board the ride, only if their excitement preferences match the ride' do
      expect(@ride1.rider_log).to eq({})
      expect(@visitor1.preferences).to include(:gentle)
      expect(@visitor2.preferences).to include(:gentle)
      expect(@visitor1.preferences).to_not include(:thrilling)
      expect(@visitor2.preferences).to include(:thrilling)
      expect(@visitor3.preferences).to include(:thrilling)

      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor1)

      expect(@ride1.rider_log).to eq({@visitor1 => 2, @visitor2 => 1})

      @ride3.board_rider(@visitor1)
      @ride3.board_rider(@visitor2)
      @ride3.board_rider(@visitor3)

      expect(@ride3.rider_log.keys).to eq([@visitor3])
      expect(@ride3.rider_log.keys).to_not include(@visitor1)
    end

    it 'allows visitors to board the ride, only if they are tall enough to ride the ride' do
      expect(@visitor1.tall_enough?(@ride1.min_height)).to be true
      expect(@visitor2.tall_enough?(@ride1.min_height)).to be true
      expect(@visitor1.tall_enough?(@ride3.min_height)).to be true
      expect(@visitor2.tall_enough?(@ride3.min_height)).to be false
      expect(@visitor3.tall_enough?(@ride3.min_height)).to be true

      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor1)

      expect(@ride1.rider_log).to eq({@visitor1 => 2, @visitor2 => 1})

      @ride3.board_rider(@visitor1)
      @ride3.board_rider(@visitor2)
      @ride3.board_rider(@visitor3)

      expect(@ride3.rider_log.keys).to eq([@visitor3])
      expect(@ride3.rider_log.keys).to_not include(@visitor2)
    end

    it 'keeps track of how many times each visitor successfully boards the ride' do
      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor1)

      expect(@ride1.rider_log.keys).to eq([@visitor1, @visitor2])
      expect(@ride1.rider_log.values).to eq([2, 1])

      @ride3.board_rider(@visitor1)
      @ride3.board_rider(@visitor2)
      @ride3.board_rider(@visitor3)

      expect(@ride3.rider_log).to eq({@visitor3 => 1})
    end

    it 'deducts the cost of the ride from the visitors spending money each time they board' do
      expect(@visitor1.spending_money).to eq(10)
      expect(@visitor2.spending_money).to eq(5)

      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor1)

      expect(@visitor1.spending_money).to eq(8)
      expect(@visitor2.spending_money).to eq(4)

      @ride3.board_rider(@visitor1)
      @ride3.board_rider(@visitor2)
      @ride3.board_rider(@visitor3)

      expect(@visitor1.spending_money).to eq(8)
      expect(@visitor2.spending_money).to eq(4)
      expect(@visitor3.spending_money).to eq(13)
    end

    it 'adds the fees collected per successful ride to the rides total revenue' do
      expect(@ride1.total_revenue).to eq(0)

      @ride1.board_rider(@visitor1)
      @ride1.board_rider(@visitor2)
      @ride1.board_rider(@visitor1)

      expect(@ride1.total_revenue).to eq(3)

      @ride3.board_rider(@visitor1)
      @ride3.board_rider(@visitor2)
      @ride3.board_rider(@visitor3)

      expect(@ride3.total_revenue).to eq(2)
    end
  end
end