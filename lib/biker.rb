class Biker
  attr_reader :name, :max_distance, :rides, :acceptable_terrain

  def initialize(name, max_distance)
    @name = name
    @max_distance = max_distance
    @rides = {}
    @acceptable_terrain = []
  end

  def learn_terrain(terrain)
    @acceptable_terrain << terrain
  end

  def log_ride(ride, time)
    # tempted to use return unless @acceptable_terrain.include?(ride.terrain) && ride.total_distance <= @max_distance instead of if statements
    if @acceptable_terrain.include?(ride.terrain) && ride.total_distance <= @max_distance
      @rides[ride] ||= []
      @rides[ride] << time
    end
  end

  def personal_record(ride)
    # once again return false unless @rides[ride]
    if @rides[ride]
      @rides[ride].min
    else
      false
    end
  end
end