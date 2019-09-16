# As a registered user
# When I send a 'GET' request to '/api/v1/user/favorites?api_key=abc123'
# Then I should receive a JSON response as follows:
#
# [
#   {
#     "id":1,
#     "neo_reference_id": "2153306",
#     "user_id": 1,
#     "asteroid": {
#       "name": "153306 (2001 JL1)",
#       "is_potentially_hazardous_asteroid": false,
#     }
#   }
# ]

require 'rails_helper'

describe 'favorites' do
  it 'registered user sends a get request and receives a list of favorite asteroids' do
    uncle_jesse = User.create!(name: "Jesse Katsopolis", email: "uncle.jesse@example.com")
    api_key = uncle_jesse.api_keys.create!(value: "abc123")
    # binding.pry
    favorites = uncle_jesse.favorites.create!(neo_reference_id: "2153306")

    get "/api/v1/user/favorites?api_key=#{api_key.value}"

    json_response = JSON.parse(response.body)

    expect(response).to be_successful
    expect(json_response).to be_an(Array)
    expect(json_response[0]).to be_a(Hash)
  end

  it 'registered user can send a POST and favorite an asteroid' do
    uncle_jesse = User.create!(name: "Jesse Katsopolis", email: "uncle.jesse@example.com")
    api_key = uncle_jesse.api_keys.create!(value: "abc123")
    favorites = uncle_jesse.favorites.create!(neo_reference_id: "2153306")

    post "/api/v1/user/favorites?api_key=#{api_key.value}&neo_reference_id=#{favorites.neo_reference_id}"

    json_response = JSON.parse(response.body)

    expect(response).to be_successful
    expect(json_response).to be_a(Hash)
    expect(favorites.neo_reference_id).to eq("2153306")
  end
end
