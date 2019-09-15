class NasaService
  def self.count_asteroids(arr)
    count = 0

    arr.each do |result|
      if result[:is_potentially_hazardous_asteroid] == true
        count += 1
      end
    end
    count
  end

  def find_asteroids_using_neo_id(neo_reference_id)
    conn = Faraday.new(url: "https://api.nasa.gov") do |f|
      f.adapter  Faraday.default_adapter
    end

    response = conn.get("/neo/rest/v1/neo/#{neo_reference_id}?api_key=lPNSUDX7JbtY5b0xPfiq0mHs4iJxO0tKcBRYA3Qf")
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.most_dangerous_day(start_date, end_date)
    conn = Faraday.new(url: 'https://api.nasa.gov') do |f|
      f.adapter  Faraday.default_adapter
    end

    response = conn.get("/neo/rest/v1/feed?start_date=#{start_date}&end_date=#{end_date}&api_key=lPNSUDX7JbtY5b0xPfiq0mHs4iJxO0tKcBRYA3Qf")
    result = JSON.parse(response.body, symbolize_names: true)

    # => most dangerous day in that range based on
    # => which day has the most `is_potentially_dangerous_asteroid`
    # => set to `true`
    #binding.pry
    p result[:near_earth_objects].nil?
    result[:near_earth_objects].map { |d, v| p d }
    result[:near_earth_objects].max_by do |date, values|
      count_asteroids(values)
    end
  end

  def self.asteroid_count_by_date(start_date)
    conn = Faraday.new(url: 'https://api.nasa.gov') do |f|
      # f.headers['api_key'] = 'lPNSUDX7JbtY5b0xPfiq0mHs4iJxO0tKcBRYA3Qf'
      f.adapter  Faraday.default_adapter
    end

    response = conn.get("/neo/rest/v1/feed?start_date=#{start_date}&api_key=lPNSUDX7JbtY5b0xPfiq0mHs4iJxO0tKcBRYA3Qf")

    result = JSON.parse(response.body, symbolize_names: true)
    # binding.pry
    result[:near_earth_objects][start_date.to_sym].length

  end
end
