require_relative 'spec_helper'

describe Visitor do
  before(:each) do
    @visitor1 = Visitor.new('Bruce', 54, '$10')
  end

  describe '#initialize' do
    it 'exists' do
      expect(@visitor1).to be_a Visitor
    end

    it 'has a name' do
      expect(@visitor1.name).to eq('Bruce')
    end

    it 'has a height' do
      expect(@visitor1.height).to eq(54)
    end

    it 'has spending money saved as an integer' do
      expect(@visitor1.spending_money).to be_a Integer
      expect(@visitor1.spending_money).to eq(10)
    end

    it 'has preferences that are empty by default' do
      expect(@visitor1.preferences).to eq([])
    end
  end

  describe '#add_preferences' do
    it 'can add multiple preferences to the visitor' do
      expect(@visitor1.preferences).to eq([])

      @visitor1.add_preferences(:gentle)
      @visitor1.add_preferences(:water)

      expect(@visitor1.preferences).to eq([:gentle, :water])
    end
  end
end
