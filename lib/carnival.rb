class Carnival
  attr_reader :duration,
              :rides

  def initialize(duration)
    @duration = duration
    @rides = []
  end

  def add_ride(ride)
    @rides << ride
  end

  def most_popular_ride
    @rides.max_by {|ride| ride.rider_log.values.sum}
  end

  def most_profitable_ride
    @rides.max_by {|ride| ride.total_revenue}
  end

  def total_ride_revenue
    @rides.map{|ride| ride.total_revenue}.sum
  end

  def get_details
    details = {}
    details[:visitor_count] = visitor_count
    details[:revenue] = total_ride_revenue
    details[:visitor_summary] = visitor_summary
    details[:ride_summary] = ride_summary
    details
  end

  def visitor_count
    @rides.map {|ride| ride.rider_log.keys}.uniq.count
  end

  def visitor_summary
    summary = {}
    visitors = @rides.map{|ride| ride.rider_log.keys}.flatten.uniq
    visitors.each do |visitor|
      summary[visitor] = [get_favorite_ride(visitor), total_spend(visitor)]
    end
    summary
  end

  def get_favorite_ride(visitor)
    all_rides = @rides.map{|ride| ride if ride.rider_log.keys.include?(visitor)}
    all_rides.delete(nil)
    favorite_ride = all_rides[0]
    all_rides.each do |ride|
      if !ride.nil? && (ride.rider_log[visitor] > favorite_ride.rider_log[visitor])
        favorite_ride = ride
      end
      favorite_ride
    end
    favorite_ride.name
  end

  def total_spend(visitor)
    total_spend = 0
    all_rides = @rides.map{|ride| ride if ride.rider_log.keys.include?(visitor)}
    all_rides.each do |ride|
      total_spend += (ride.rider_log[visitor] * ride.admission_fee) unless ride.nil?
    end
    total_spend
  end

  def ride_summary
    summary = {}
    @rides.each do |ride|
      summary[ride] = [ride.rider_log.keys, ride.total_revenue]
    end
    summary
  end
end
