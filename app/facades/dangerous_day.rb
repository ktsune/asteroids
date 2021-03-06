class DangerousDay
  attr_reader :service

  def initialize(start_date, end_date)
    @start_date = start_date
    @end_date = end_date
    p 'new dangerous day'
  end

  def start_date
    start = Date.parse(@start_date)
    start.strftime("%B %-d, %Y")
  end

  def end_date
    start = Date.parse(@end_date)
    start.strftime("%B %-d, %Y")
  end

  def nasa_date(date)
    Date.parse(date).strftime("%Y-%m-%d")
  end

  def most_dangerous_day
    @most_dangerous_day ||= NasaService.most_dangerous_day(nasa_date(@start_date), nasa_date(@end_date)).first
  end

  def asteroid_count
    @asteroid_count ||= NasaService.asteroid_count_by_date(most_dangerous_day)
  end

  def asteroid_list
    asteroids = NasaService.most_dangerous_day(nasa_date(@start_date), nasa_date(@end_date)).last
    asteroids.select do |result|
      result[:is_potentially_hazardous_asteroid] == true
    end
  end
end
