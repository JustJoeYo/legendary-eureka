require_relative 'spec_helper'

RSpec.configure do |config|
  config.formatter = :documentation
end

RSpec.describe BikeClub do
  before(:each) do
    @bike_club = BikeClub.new("Mountain Riders")
    @biker1 = Biker.new("Kenny", 30)
    @biker2 = Biker.new("Athena", 15)
    @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
    @ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})
  end

  describe 'initialization' do
    it '#initialize' do
      expect(@bike_club).to be_a(BikeClub)
    end

    it '#attributes' do
      expect(@bike_club.name).to eq("Mountain Riders")
      expect(@bike_club.bikers).to eq([])
    end
  end

  describe 'instance methods' do
    
  end
end