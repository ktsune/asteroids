
uncle_jesse = User.create(name: "Jesse Katsopolis", email: "uncle.jesse@example.com")
uncle_jesse.api_keys.create(value: "abc123")
uncle_jesse.favorites.create(neo_reference_id: "2153306")
