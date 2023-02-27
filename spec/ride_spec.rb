require_relative 'spec_helper'

describe Ride do
  before(:each) do
    @ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
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
end