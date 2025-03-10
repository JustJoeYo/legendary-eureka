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
    it '#add_biker' do
      @bike_club.add_biker(@biker1)
      @bike_club.add_biker(@biker2)
      expect(@bike_club.bikers).to eq([@biker1, @biker2])
    end

    it '#most_rides' do
      @biker1.learn_terrain(:hills)
      @biker1.learn_terrain(:gravel)
      @biker1.log_ride(@ride1, 92.5)
      @biker1.log_ride(@ride1, 91.1)
      @biker1.log_ride(@ride2, 60.9)
      @biker1.log_ride(@ride2, 61.6)

      @biker2.learn_terrain(:gravel)
      @biker2.log_ride(@ride2, 65.0)

      @bike_club.add_biker(@biker1)
      @bike_club.add_biker(@biker2)

      expect(@bike_club.most_rides).to eq(@biker1)
    end

    it '#best_time' do
      @biker1.learn_terrain(:hills)
      @biker1.learn_terrain(:gravel)
      @biker1.log_ride(@ride1, 92.5)
      @biker1.log_ride(@ride1, 91.1)
      @biker1.log_ride(@ride2, 60.9)
      @biker1.log_ride(@ride2, 61.6)

      @biker2.learn_terrain(:gravel)
      @biker2.log_ride(@ride2, 65.0)

      @bike_club.add_biker(@biker1)
      @bike_club.add_biker(@biker2)

      expect(@bike_club.best_time(@ride1)).to eq(@biker1)
      expect(@bike_club.best_time(@ride2)).to eq(@biker1)
    end

    it '#bikers_eligible' do
      @biker1.learn_terrain(:hills)
      @biker1.learn_terrain(:gravel)
      @biker2.learn_terrain(:gravel)

      @bike_club.add_biker(@biker1)
      @bike_club.add_biker(@biker2)

      expect(@bike_club.bikers_eligible(@ride1)).to eq([@biker1])
      expect(@bike_club.bikers_eligible(@ride2)).to eq([@biker1, @biker2])
    end

    it '#record_group_ride' do
      allow(Time).to receive(:now).and_return(Time.new(2025, 3, 10, 10, 0, 0))
      @biker1.learn_terrain(:hills)
      @biker1.learn_terrain(:gravel)
      @biker2.learn_terrain(:gravel)

      @bike_club.add_biker(@biker1)
      @bike_club.add_biker(@biker2)

      result = @bike_club.record_group_ride(@ride1)
      expect(result[:start_time]).to eq(Time.new(2025, 3, 10, 10, 0, 0))
      expect(result[:ride]).to eq(@ride1)
      expect(result[:members]).to eq([@biker1])
    end

    it '#group_rides' do
      allow(Time).to receive(:now).and_return(Time.new(2025, 3, 10, 10, 0, 0))
      @biker1.learn_terrain(:hills)
      @biker1.learn_terrain(:gravel)
      @biker2.learn_terrain(:gravel)

      @bike_club.add_biker(@biker1)
      @bike_club.add_biker(@biker2)

      @bike_club.record_group_ride(@ride1)
      @bike_club.record_group_ride(@ride2)

      expect(@bike_club.group_rides.size).to eq(2)
    end
  end

  describe 'class variables' do
    it '@@all_clubs' do
      expect(BikeClub.class_variable_get(:@@all_clubs)).to eq([@bike_club])
    end

    it '#best_rider' do
      @bike_club1 = BikeClub.new("Mountain Riders")
      @bike_club2 = BikeClub.new("Other Riders Lol")

      @biker1.learn_terrain(:hills)
      @biker1.learn_terrain(:gravel)
      @biker1.log_ride(@ride1, 92.5)
      @biker1.log_ride(@ride1, 91.1)
      @biker1.log_ride(@ride2, 60.9)
      @biker1.log_ride(@ride2, 61.6)

      @biker2.learn_terrain(:gravel)
      @biker2.log_ride(@ride2, 65.0)

      @bike_club1.add_biker(@biker1)
      @bike_club2.add_biker(@biker2)

      expect(BikeClub.best_rider(@ride1)).to eq(@biker1)
      expect(BikeClub.best_rider(@ride2)).to eq(@biker1)
    end
  end
end