require 'rails_helper'

describe NasaService do
  it 'can retreive most dangerous day' do
    start_date = "2018-01-01"
    end_date = "2018-01-07"

    nasa_data = NasaService.most_dangerous_day(start_date, end_date)

    expect(nasa_data).to be_an(Array)
    expect(nasa_data[0]).to be_a(Symbol)
    expect(nasa_data[1]).to be_an(Array)
  end
end
