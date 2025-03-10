require_relative 'spec_helper'

RSpec.configure do |config|
  config.formatter = :documentation
end

RSpec.describe Biker do
  before(:each) do
    @biker = Biker.new("Kenny", 30)
    @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
    @ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})
  end

  describe 'initialization' do
    it '#initialize' do
      expect(@biker).to be_a(Biker)
    end

    it '#attributes' do
      expect(@biker.name).to eq("Kenny")
      expect(@biker.max_distance).to eq(30)
      expect(@biker.rides).to eq({})
      expect(@biker.acceptable_terrain).to eq([])
    end
  end

  describe 'instance methods' do
    it '#learn_terrain' do
      @biker.learn_terrain(:gravel)
      @biker.learn_terrain(:hills)
      expect(@biker.acceptable_terrain).to eq([:gravel, :hills])
    end

    it '#log_ride' do
      @biker.learn_terrain(:hills)
      @biker.learn_terrain(:gravel)
      @biker.log_ride(@ride1, 92.5)
      @biker.log_ride(@ride1, 91.1)
      @biker.log_ride(@ride2, 60.9)
      @biker.log_ride(@ride2, 61.6)
      expect(@biker.rides).to eq({
        @ride1 => [92.5, 91.1],
        @ride2 => [60.9, 61.6]
      })
    end

    it '#personal_record' do
      @biker.learn_terrain(:hills)
      @biker.learn_terrain(:gravel)
      @biker.log_ride(@ride1, 92.5)
      @biker.log_ride(@ride1, 91.1)
      @biker.log_ride(@ride2, 60.9)
      @biker.log_ride(@ride2, 61.6)
      expect(@biker.personal_record(@ride1)).to eq(91.1)
      expect(@biker.personal_record(@ride2)).to eq(60.9)
    end
  end
end