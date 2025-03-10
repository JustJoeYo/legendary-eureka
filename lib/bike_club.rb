class BikeClub
  attr_reader :name, :bikers, :group_rides

  @@all_clubs = []

  def initialize(name)
    @name = name
    @bikers = []
    @group_rides = []
    @@all_clubs << self # @@all_clubs is a class variable, shared among all instances of the BikeClub class (would forget if no notes forgive me mike)
  end

  def add_biker(biker)
    @bikers << biker
  end

  def most_rides
    @bikers.max_by { |biker| biker.rides.values.flatten.size }
  end

  def best_time(ride)
    eligible_bikers = @bikers.select { |biker| biker.rides[ride] }
    eligible_bikers.min_by { |biker| biker.personal_record(ride) }
  end

  def bikers_eligible(ride)
    @bikers.select do |biker|
      biker.acceptable_terrain.include?(ride.terrain) && ride.total_distance <= biker.max_distance
    end
  end

  def record_group_ride(ride)
    start_time = Time.now
    eligible_members = bikers_eligible(ride)
    eligible_members.each do |biker|
      finish_time = Time.now + rand(30..120) * 60 # Random finish time between 30 to 120 minutes
      ride_time = (finish_time - start_time) / 60 # Convert seconds to minutes
      biker.log_ride(ride, ride_time)
    end
    group_ride = { start_time: start_time, ride: ride, members: eligible_members }
    @group_rides << group_ride
    group_ride
  end

  def self.best_rider(ride)
    all_bikers = @@all_clubs.flat_map(&:bikers) # wish i didnt have to use flat_map so soon, hasnt been long enough.
    eligible_bikers = all_bikers.select { |biker| biker.rides[ride] }
    eligible_bikers.min_by { |biker| biker.personal_record(ride) }
  end
end